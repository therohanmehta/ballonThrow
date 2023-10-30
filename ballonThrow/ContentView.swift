import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var score = 0
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    let numberOfModels = 2
    @State private var modelStates = Array(repeating: true, count: 10) // Array to track the visibility of each model

    var body: some View {
        VStack {
            VStack {
                Text("Score: \(score)")
                    .glassBackgroundEffect()
                    .frame(width: 100, height:100)

                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
            }

            ForEach(0..<numberOfModels, id: \.self) { index in
                if modelStates[index] {
                    Model3D(named: "Sceneearth", bundle: realityKitContentBundle)
                        .padding(.bottom, 50)
                        .onTapGesture {
                            // Increase the score by 1 and hide the model
                            score += 1
                            modelStates[index] = false
                        }
                }
            }
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "Immersive") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
        
        Button("show saturn"){
            Task{
                await openImmersiveSpace(id: "saturn")
            }
        }
    }
}
#Preview(windowStyle: .automatic) {
    ContentView()
}
