# spine-android

The spine-android runtime provides Android integration for Spine using `spine-libgdx`.

# Releasing

`spine-android` is released in lock-step with `spine-libgdx`. Its version is read from `spine-libgdx/gradle.properties`, and its published POM depends on the matching `spine-libgdx` version.

To release, commit the non-SNAPSHOT release version in `spine-libgdx/gradle.properties`, then tag that commit with `spine-libgdx-<version>` and push the tag:

```
git tag spine-libgdx-4.3.2 <commit>
git push origin spine-libgdx-4.3.2
```

The GitHub Actions release workflow verifies the tag version, publishes `spine-libgdx` first, then publishes `spine-android` with the same version. After the release, bump `spine-libgdx/gradle.properties` to the next `-SNAPSHOT` version in a follow-up commit.
