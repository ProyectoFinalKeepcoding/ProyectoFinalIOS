//
//  Coordinator.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import Foundation
import GoogleMaps
import SwiftUI

/// Coordinator that functions as a map delegate which presents the methods for adding markers and
/// click on it to show the detail
class Coordinator: NSObject, GMSMapViewDelegate {
    var places: [ShelterPointModel] = []
    
    var onMarkerClick: (ShelterPointModel) -> ()
    
    init(_ onMarkerClick: @escaping (ShelterPointModel) -> Void) {
        self.onMarkerClick = onMarkerClick
    }
    
    /// Function to add markers to map
    /// - Parameter mapView: mapView associated
    func addMarkers(mapView: GMSMapView) {
        places.forEach { place in
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: place.address.latitude, longitude: place.address.longitude))
            
            switch place.shelterType {
            case .particular:
                marker.iconView = setMarkerImage(image: UIImage(named: "particular"), size: 30)
            case .shelterPoint:
                marker.iconView = setMarkerImage(image: UIImage(named: "animal-shelter"), size: 30)
            case .veterinary:
                marker.iconView = setMarkerImage(image: UIImage(named: "veterinary"), size: 30)
            case .localGovernment:
                marker.iconView = setMarkerImage(image: UIImage(named: "town-council"), size: 30)
            case .kiwokoStore:
                marker.iconView = setMarkerImage(image: UIImage(named: "kiwoko-shop"), size: 30)
            }
            
            marker.title = place.name
            marker.map = mapView
        }
    }
    
    /// Function to set marker image
    /// - Parameters:
    ///   - image: image content
    ///   - size: image size
    /// - Returns: UIIMageView with selected components
    func setMarkerImage(image: UIImage?, size: Int) -> UIImageView{
        guard let image else {
            return UIImageView(image: UIImage(systemName: "house.lodge"))
        }
//        let tintedImage = image.withTintColor(color, renderingMode: .alwaysOriginal)
        let scaledImage = image.resizeImageTo(size: CGSize(width: size, height: size))
        return UIImageView(image: scaledImage)
    }
    
    /// Function that handles the event of clicking on a marker to show detail and animate to position
    /// - Parameters:
    ///   - mapView: View representing the map
    ///   - marker: marker in which user has tapped
    /// - Returns: Bool by default inherited from GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let place = places.filter {
            $0.name == marker.title
        }.first!

        onMarkerClick(place)
        Map.locationManager.lastFocusedLocation = CLLocation(latitude: place.address.latitude, longitude: place.address.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: place.address.latitude, longitude: place.address.longitude, zoom: 9)

        mapView.animate(to: camera)
        
        return true
    }
    
}
