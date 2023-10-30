//
//  ballonThrowApp.swift
//  ballonThrow
//
//  Created by Dev on 27/10/23.
//

import SwiftUI

@main
struct ballonThrowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
//        .defaultSize(width: 5000, height: 5000, depth: 5000)
        ImmersiveSpace(id: "Immersive") {
            ImmersiveView()
        }
        
        ImmersiveSpace(id: "saturn") {
            Planets()
        }
    }
}
//
