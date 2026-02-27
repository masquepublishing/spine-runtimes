/******************************************************************************
 * Spine Runtimes License Agreement
 * Last updated April 5, 2025. Replaces all prior versions.
 *
 * Copyright (c) 2013-2025, Esoteric Software LLC
 *
 * Integration of the Spine Runtimes into software or otherwise creating
 * derivative works of the Spine Runtimes is permitted under the terms and
 * conditions of Section 2 of the Spine Editor License Agreement:
 * http://esotericsoftware.com/spine-editor-license
 *
 * Otherwise, it is permitted to integrate the Spine Runtimes into software
 * or otherwise create derivative works of the Spine Runtimes (collectively,
 * "Products"), provided that each user of the Products must obtain their own
 * Spine Editor license and redistribution of the Products in any form must
 * include this license and copyright notice.
 *
 * THE SPINE RUNTIMES ARE PROVIDED BY ESOTERIC SOFTWARE LLC "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ESOTERIC SOFTWARE LLC BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES,
 * BUSINESS INTERRUPTION, OR LOSS OF USE, DATA, OR PROFITS) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THE SPINE RUNTIMES, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/

import SpineSwift
import SpineiOS
import SwiftUI

struct DressUp: View {

    @StateObject
    var model = DressUpModel()

    var body: some View {
        HStack(spacing: 0) {
            List {
                ForEach(model.skinImages.keys.sorted(), id: \.self) { skinName in
                    let rawImageData = model.skinImages[skinName]!
                    Button(action: { model.toggleSkin(skinName: skinName) }) {
                        Image(uiImage: UIImage(cgImage: rawImageData))
                            .resizable()
                            .scaledToFit()
                            .frame(width: model.thumbnailSize.width, height: model.thumbnailSize.height)
                            .grayscale(model.selectedSkins[skinName] == true ? 0.0 : 1.0)
                    }
                }
            }
            .listStyle(.plain)

            Divider()

            if let drawable = model.drawable {
                SpineView(
                    from: .drawable(drawable),
                    controller: model.controller,
                    boundsProvider: model.boundsProvider
                )
            } else {
                Spacer()
            }
        }
        .navigationTitle("Dress Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DressUp()
}

final class DressUpModel: ObservableObject {

    let thumbnailSize = CGSize(width: 200, height: 200)
    let boundsProvider: BoundsProvider = SkinAndAnimationBounds(skins: ["full-skins/girl"])

    @Published
    var controller: SpineController

    @Published
    var drawable: SkeletonDrawableWrapper?

    @Published
    var skinImages = [String: CGImage]()

    @Published
    var selectedSkins = [String: Bool]()

    private var customSkin: Skin?

    init() {
        controller = SpineController(
            onInitialized: { controller in
                controller.animationState.setAnimation(0, "dance", true)
            },
            disposeDrawableOnDeInit: false
        )
        Task.detached(priority: .high) {
            let drawable = try await SkeletonDrawableWrapper.fromBundle(
                atlasFileName: "mix-and-match-pma.atlas",
                skeletonFileName: "mix-and-match-pro.skel"
            )
            try await MainActor.run {
                let skins = drawable.skeletonData.skins
                for i in 0..<skins.count {
                    guard let skin = skins[i] else { continue }
                    if skin.name == "default" { continue }
                    let skeleton = drawable.skeleton
                    skeleton.setSkin2(skin)
                    skeleton.setupPose()
                    skeleton.update(0)
                    skeleton.updateWorldTransform(SpineSwift.Physics.update)
                    let skinName = skin.name
                    self.skinImages[skinName] = try drawable.renderToImage(
                        size: self.thumbnailSize,
                        boundsProvider: self.boundsProvider,
                        backgroundColor: .white,
                        scaleFactor: UIScreen.main.scale
                    )
                    self.selectedSkins[skinName] = false
                }
                self.toggleSkin(skinName: "full-skins/girl", drawable: drawable)
                self.drawable = drawable
            }
        }
    }

    deinit {
        drawable?.dispose()
        customSkin?.dispose()
    }

    func toggleSkin(skinName: String) {
        if let drawable {
            toggleSkin(skinName: skinName, drawable: drawable)
        }
    }

    func toggleSkin(skinName: String, drawable: SkeletonDrawableWrapper) {
        selectedSkins[skinName] = !(selectedSkins[skinName] ?? false)
        customSkin?.dispose()
        customSkin = Skin("custom-skin")
        for skinName in selectedSkins.keys {
            if selectedSkins[skinName] == true {
                if let skin = drawable.skeletonData.findSkin(skinName) {
                    customSkin?.addSkin(skin)
                }
            }
        }
        drawable.skeleton.setSkin2(customSkin)
        drawable.skeleton.setupPose()
    }
}
