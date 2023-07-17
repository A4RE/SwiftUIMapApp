//
//  LocationPreviewView.swift
//  MapProject
//
//  Created by Андрей Коваленко on 06.06.2023.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var lvm: LocationViewModel
    
    let location: Location
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            VStack(alignment: .leading, spacing: 12) {
                learnMoreButton
                HStack {
                    prevButton
                    nextButton
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .offset(y: 60)
        )
        .cornerRadius(12)
        .clipped()
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding(9)
        }
        .environmentObject(LocationViewModel())
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var learnMoreButton: some View {
        Button {
            lvm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
    private var nextButton: some View {
        Button {
            lvm.nextButtonPressed()
        } label: {
            Image(systemName: "arrow.right")
                .font(.headline)
                .frame(width: 62, height: 30)
        }
        .buttonStyle(.bordered)
    }
    private var prevButton: some View {
        Button {
            lvm.prevButtonPressed()
        } label: {
            Image(systemName: "arrow.left")
                .font(.headline)
                .frame(width: 62, height: 30)
        }
        .buttonStyle(.bordered)
    }
}
