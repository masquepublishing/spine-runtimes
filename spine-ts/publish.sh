#!/bin/bash
set -e
cd "$(dirname "$0")"

# Source logging utilities
source ../formatters/logging/logging.sh

BRANCH=$(git symbolic-ref --short -q HEAD)
if ! echo "$BRANCH" | grep -qE '^[0-9]+\.[0-9]+$'; then
    echo "Error: publish.sh can only be run from release branches named number.number, e.g. 4.3. Current branch: $BRANCH"
    exit 1
fi

log_title "Spine TypeScript Publisher"

# Get current version
currentVersion=$(grep -o '"version": "[^"]*' package.json | grep -o '[^"]*$')
major=$(echo "$currentVersion" | cut -d. -f1)
minor=$(echo "$currentVersion" | cut -d. -f2)
patch=$(echo "$currentVersion" | cut -d. -f3)
newPatch=$((patch + 1))
newVersion="$major.$minor.$newPatch"

log_detail "Branch: $BRANCH"
log_detail "Current version: $currentVersion"
log_detail "New version: $newVersion"

CHANGELOG_FILE="CHANGELOG.md"
if [ -f "$CHANGELOG_FILE" ]; then
    unreleasedChanges=$(python3 - <<'PY'
from pathlib import Path
import re

text = Path("CHANGELOG.md").read_text()
match = re.search(r"(?ms)^## Unreleased\s*\n(?P<body>.*?)(?=^##\s+)", text)
if match and match.group("body").strip():
    print("yes")
PY
)

    if [ "$unreleasedChanges" = "yes" ]; then
        log_detail "CHANGELOG.md has unreleased changes."
        read -p "Move unreleased CHANGELOG.md entries to $newVersion with today's date? [y/N] " UPDATE_CHANGELOG
        case "$UPDATE_CHANGELOG" in
            [yY]|[yY][eE][sS])
                today=$(date +%Y-%m-%d)
                log_action "Updating CHANGELOG.md"
                if CHANGELOG_OUTPUT=$(NEW_VERSION="$newVersion" RELEASE_DATE="$today" python3 - <<'PY' 2>&1
from pathlib import Path
import os
import re
import sys

path = Path("CHANGELOG.md")
text = path.read_text()
version = os.environ["NEW_VERSION"]
date = os.environ["RELEASE_DATE"]
match = re.search(r"(?ms)^## Unreleased\s*\n(?P<body>.*?)(?=^##\s+)", text)
if not match:
    print("Could not find an Unreleased section in CHANGELOG.md", file=sys.stderr)
    sys.exit(1)
body = match.group("body").strip()
if not body:
    sys.exit(0)
replacement = f"## Unreleased\n\n## {version} - {date}\n\n{body}\n\n"
text = text[:match.start()] + replacement + text[match.end():]
path.write_text(text)
PY
                ); then
                    log_ok
                else
                    log_fail
                    log_error_output "$CHANGELOG_OUTPUT"
                    exit 1
                fi
                ;;
            *)
                log_detail "Leaving unreleased CHANGELOG.md entries unchanged."
                ;;
        esac
    else
        log_detail "CHANGELOG.md has no unreleased changes."
    fi
else
    log_warn "CHANGELOG.md not found; skipping changelog update."
fi

packages=(
    "package.json"
    "spine-canvas/package.json"
    "spine-canvaskit/package.json"
    "spine-core/package.json"
    "spine-phaser-v3/package.json"
    "spine-phaser-v4/package.json"
    "spine-pixi-v7/package.json"
    "spine-pixi-v8/package.json"
    "spine-player/package.json"
    "spine-threejs/package.json"
    "spine-webgl/package.json"
    "spine-webcomponents/package.json"
)

for package in "${packages[@]}"; do
    log_action "Updating $package"
    if SED_OUTPUT=$(sed -i '' "s/$currentVersion/$newVersion/" "$package" 2>&1); then
        log_ok
    else
        log_fail
        log_error_output "$SED_OUTPUT"
        exit 1
    fi
done

log_action "Removing package-lock.json"
if RM_OUTPUT=$(rm package-lock.json 2>&1); then
    log_ok
else
    log_warn
fi

log_action "Cleaning @esotericsoftware modules"
if RM_OUTPUT=$(rm -rf node_modules/@esotericsoftware 2>&1); then
    log_ok
else
    log_warn
fi

log_action "Installing workspace dependencies"
if NPM_OUTPUT=$(npm install --workspaces 2>&1); then
    log_ok
else
    log_fail
    log_error_output "$NPM_OUTPUT"
    exit 1
fi

read -p "npm OTP: " NPM_OTP

log_action "Publishing all workspaces"
if NPM_OUTPUT=$(npm publish --access public --workspaces --otp="$NPM_OTP" 2>&1); then
    log_ok
    log_summary "✓ TypeScript packages published successfully with version $newVersion"
else
    log_fail
    log_error_output "$NPM_OUTPUT"
    exit 1
fi