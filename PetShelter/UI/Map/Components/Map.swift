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
    @Binding var selectedMarker: GMSMarker?
    var onMarkerClick: (GMSMarker) -> ()
    
    typealias UIViewType = GMSMapView
    
    private let gmsMapView = GMSMapView(frame: .zero)
    private let defaultZoomLevel: Float = 10
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)
        gmsMapView.camera = GMSCameraPosition.camera(withTarget: sanFrancisco, zoom: defaultZoomLevel)
        gmsMapView.isUserInteractionEnabled = true
        gmsMapView.delegate = context.coordinator
        return gmsMapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        markers.forEach { marker in
            marker.map = uiView
            
        }
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(gmsMapView,onMarkerClick)
    }
    
    
}

final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
    var mapView: GMSMapView
    var onMarkerClick: (GMSMarker) -> ()
    
    init(_ mapView: GMSMapView, _ onMarkerClick: @escaping (GMSMarker) -> () ) {
        self.mapView = mapView
        self.onMarkerClick = onMarkerClick
    }
    

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        onMarkerClick(marker)
        return true
    }
}

//struct Map_Previews: PreviewProvider {
//    static var previews: some View {
//        Map()
//    }
//}
