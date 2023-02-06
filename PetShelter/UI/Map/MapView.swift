//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import GoogleMaps
import SwiftUI

struct MapView: View {
    
    @State var markers: [GMSMarker] = shelters.map {
        let marker = GMSMarker(position: $0.coordinate)
        marker.title = $0.name
        return marker
    }
    var body: some View {
        VStack {
            Header()
            ZStack {
                Map(markers: $markers)
                    .ignoresSafeArea()
                AidButton()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(markers: shelters.map {
            let marker = GMSMarker(position: $0.coordinate)
            marker.title = $0.name
            return marker
        })
    }
}

let shelters = [
    Shelter(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)),
    Shelter(name: "Seattle", coordinate: CLLocationCoordinate2D(latitude: 47.6131742, longitude: -122.4824903)),
    Shelter(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3440852, longitude: 103.6836164)),
    Shelter(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.8473552, longitude: 150.6511076)),
]
