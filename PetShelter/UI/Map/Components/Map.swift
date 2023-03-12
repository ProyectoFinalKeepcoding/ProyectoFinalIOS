//
//  Map.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import GoogleMaps
/// Struct para representar un mapa en SwiftUI con métodos para actualizar la vista
/// y vinculado al viewModel , coordinator y locationManager
struct Map: UIViewRepresentable {

    var viewModel: MapViewModel
    @Binding var coordinates: [ShelterPointModel]
    var onMarkerClick: (ShelterPointModel) -> ()
    
    @ObservedObject static var locationManager = LocationManager()
    private let zoom: Float = 5.0
    
    typealias UIViewType = GMSMapView
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: Map.locationManager.latitude, longitude: Map.locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.padding = UIEdgeInsets(top: 0, left: 100, bottom: 120, right: 0)
        mapView.delegate = context.coordinator
        setSubscriber(mapView)
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if Map.locationManager.lastFocusedLocation == nil {
            moveToUserLocation(mapView)
        }
        
        context.coordinator.places = coordinates
        context.coordinator.addMarkers(mapView: mapView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onMarkerClick)
    }
    
    func setSubscriber(_ mapView: GMSMapView){
        
        viewModel.cancellable = viewModel.$closestShelter.sink(receiveValue: { shelterPoint in
            
            guard let latitude = shelterPoint?.address.latitude, let longitud = shelterPoint?.address.longitude else {
                
                return
            }
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitud, zoom: 9)
            
            mapView.animate(to: camera)
        })
   }
    
    func moveToUserLocation(_ mapView: GMSMapView) {
        let camera = GMSCameraPosition.camera(withLatitude: Map.locationManager.latitude, longitude: Map.locationManager.longitude, zoom: 9)

        mapView.animate(to: camera)
    }
 
    
}

//struct Map_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Map()
//            .coordinates
//    }
//}
