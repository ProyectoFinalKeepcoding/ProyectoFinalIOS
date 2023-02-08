//
//  Map.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import GoogleMaps

struct Map: UIViewRepresentable {
    @Binding var coordinates: [ShelterPointModel]
    var onMarkerClick: (ShelterPointModel) -> ()
    
    typealias UIViewType = GMSMapView
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(latitude: 38.3875, longitude: -0.5246, zoom: 5)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        context.coordinator.places = coordinates
        context.coordinator.addMarkers(mapView: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onMarkerClick)
    }
    
}

//struct Map_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Map()
//            .coordinates
//    }
//}
