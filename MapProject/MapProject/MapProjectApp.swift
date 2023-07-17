//
//  MapProjectApp.swift
//  MapProject
//
//  Created by Андрей Коваленко on 02.06.2023.
//

import SwiftUI

@main
struct MapProjectApp: App {
    
    @StateObject private var lvm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(lvm)
        }
    }
}
