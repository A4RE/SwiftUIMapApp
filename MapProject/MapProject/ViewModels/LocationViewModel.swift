//
//  LocationViewModel.swift
//  MapProject
//
//  Created by Андрей Коваленко on 02.06.2023.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    //Current location on map
    @Published var mapLocation: Location {
        didSet {
            updMapRegion(location: mapLocation)
        }
    }
    // Current region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of location
    @Published var showLocationList: Bool = false
    
    // Show location detail sheet
    @Published var sheetLocation: Location? = nil
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updMapRegion(location: locations.first!)
    }
    
    private func updMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
        
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        // get the current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Couldn't find current index in Locations Array")
            return
        }
        
        // Check is current Index is Valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index is not valid, restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        // Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    func prevButtonPressed() {
        // get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Couldn't find current index in Locations Array")
            return
        }
        // Check is current index is Valid
        let prevIndex = currentIndex - 1
        guard locations.indices.contains(prevIndex) else {
            // next index is not valid, restart from 0
            guard let lastIndex = locations.last else { return }
            showNextLocation(location: lastIndex)
            return
        }
        // prev index is valid
        let prevLocation = locations[prevIndex]
        showNextLocation(location: prevLocation)
    }
}
