//
//  Map.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import GoogleMaps

struct Map: UIViewRepresentable {
    
    @Binding var markers: [GMSMarker]
//    @Binding var selectedMarker: GMSMarker?
    
    typealias UIViewType = GMSMapView
    
    private let gmsMapView = GMSMapView(frame: .zero)
    private let defaultZoomLevel: Float = 10
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)
        gmsMapView.camera = GMSCameraPosition.camera(withTarget: sanFrancisco, zoom: defaultZoomLevel)
        gmsMapView.isUserInteractionEnabled = true
        return gmsMapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        markers.forEach { marker in
            marker.map = uiView
        }
    }
    
}

//struct Map_Previews: PreviewProvider {
//    static var previews: some View {
//        Map()
//    }
//}
