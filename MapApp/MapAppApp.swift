//
//  MapAppApp.swift
//  MapApp
//
//  Created by PC on 16/09/22.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject private var vm = LocationsVieModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
