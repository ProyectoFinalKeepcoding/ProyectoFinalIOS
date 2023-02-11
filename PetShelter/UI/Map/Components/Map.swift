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
    
    @StateObject var locationManager = LocationManager()
    private let zoom: Float = 5.0
    
    typealias UIViewType = GMSMapView
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        mapView.camera = camera
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
        context.coordinator.places = coordinates
        context.coordinator.addMarkers(mapView: mapView)
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
