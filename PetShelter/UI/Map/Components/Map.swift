//
//  Map.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import GoogleMaps

struct Map: UIViewRepresentable {
    
    typealias UIViewType = GMSMapView
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(latitude: 45, longitude: 45, zoom: 8)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        //
    }
    
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
