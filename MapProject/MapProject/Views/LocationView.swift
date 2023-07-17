//
//  LocationView.swift
//  MapProject
//
//  Created by Андрей Коваленко on 02.06.2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var lvm: LocationViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(.top, 8)
                    .padding(.horizontal, 10)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $lvm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationView {
    private var header: some View {
        VStack {
            Button {
                lvm.toggleLocationsList()
            } label: {
                Text(lvm.mapLocation.name + ", " + lvm.mapLocation.cityName)
                    .font(.system(.title2, weight: .black))
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: lvm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: lvm.showLocationList ? 180 : 0))
                    }
            }

            if lvm.showLocationList {
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    private var mapLayer: some View {
        Map(coordinateRegion: $lvm.mapRegion, annotationItems: lvm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(lvm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        lvm.showNextLocation(location: location)
                    }
            }
        }
    }
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(lvm.locations) { location in
                if lvm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding(.bottom, 15)
                        .padding(.horizontal, 8)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
