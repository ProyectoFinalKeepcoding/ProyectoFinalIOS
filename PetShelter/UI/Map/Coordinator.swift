//
//  Coordinator.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import Foundation
import GoogleMaps
import SwiftUI

/// Coordinator que funciona como delegado del mapa que presenta los métodos para añadir marcadores y
/// click en el mismo para mostrar el detalle
class Coordinator: NSObject, GMSMapViewDelegate {
    var places: [ShelterPointModel] = []
    
    var onMarkerClick: (ShelterPointModel) -> ()
    
    init(_ onMarkerClick: @escaping (ShelterPointModel) -> Void) {
        self.onMarkerClick = onMarkerClick
    }
    
    func addMarkers(mapView: GMSMapView) {
        places.forEach { place in
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: place.address.latitude, longitude: place.address.longitude))
            
            switch place.shelterType {
            case .particular:
                marker.iconView = setMarkerImage(image: UIImage(named: "particular"), size: 30, color: .red)
            case .shelterPoint:
                marker.iconView = setMarkerImage(image: UIImage(named: "animal-shelter"), size: 30, color: .black)
            case .veterinary:
                marker.iconView = setMarkerImage(image: UIImage(named: "veterinary"), size: 30, color: .blue)
            case .localGovernment:
                marker.iconView = setMarkerImage(image: UIImage(named: "town-council"), size: 30, color: .brown)
            case .kiwokoStore:
                marker.iconView = setMarkerImage(image: UIImage(named: "kiwoko-shop"), size: 30, color: .brown)
            }
            
            marker.title = place.name
            marker.map = mapView
        }
    }
    
    func setMarkerImage(image: UIImage?, size: Int, color: UIColor) -> UIImageView{
        guard let image else {
            return UIImageView(image: UIImage(systemName: "house.lodge"))
        }
        let tintedImage = image.withTintColor(color, renderingMode: .alwaysOriginal)
        let scaledImage = tintedImage.resizeImageTo(size: CGSize(width: size, height: size))
        return UIImageView(image: scaledImage)
    }
    
    /// Función que gestiona el evento de hacer clice en un marcador para mostrar detalle
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let place = places.filter {
            $0.name == marker.title
        }.first!

        onMarkerClick(place)
        Map.locationManager.lastFocusedLocation = CLLocation(latitude: place.address.latitude, longitude: place.address.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: place.address.latitude, longitude: place.address.longitude, zoom: 9)
        mapView.camera = camera
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: place.address.latitude, longitude: place.address.longitude))
        
        return true
    }
    
}
