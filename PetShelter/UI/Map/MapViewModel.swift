//
//  MapViewModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation
import GoogleMaps
import SwiftUI
import CoreLocation


final class MapViewModel: ObservableObject {
//    @EnvironmentObject var locationManager: LocationManager
    
    cancellable = locationManager.$location.sink { ... }
    
    private var repository: Repository
    @Published var locations = [ShelterPointModel]()
    
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func getShelterPoints() async {
        let result = await repository.fetchShelterPoints()
        
        switch result {
        case .success(let points):
            locations = points
            print(locations)
        case .failure(let error):
            print(error)
        }
    }
    
    
    // MARK: onClickButton
    func onClickClosestShelter() {
        //TODO: #1 Get Closest Shelter
        let closestShelter = getClosestShelter()
        
        // TODO: #2 Activate Modal Shelter
        
        // TODO: #3 Zoom camera to this Shelter
    }
    
    // MARK: Get closest Shelter from current location
    func getClosestShelter() -> ShelterPointModel? {
        
        //TODO: #1 Get origin coordiantes
        let origin = CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude )
        
        
//        let origin = CLLocationCoordinate2D(latitude: 40.4165, longitude: -3.70256)
        
        
        //TODO: #2 init closestShelter

        var closestShelter: ShelterPointModel?
        
        closestShelter = locations
            .filter({$0.address.latitude - origin.latitude <= 1 &&  $0.address.latitude - origin.latitude <= 1})
        
            .sorted { shelter1, shelter2 in
                
                let coordinatesShelter1 = CLLocationCoordinate2D(latitude: shelter1.address.latitude, longitude: shelter1.address.longitude)

                let coordinatesShelter2 = CLLocationCoordinate2D(latitude: shelter2.address.latitude,  longitude: shelter2.address.longitude)
                
                let distance1 = distanceBetweenWithCoreLocation(origin: origin, destination: coordinatesShelter1)
                
                let distance2 = distanceBetweenWithCoreLocation(origin: origin, destination: coordinatesShelter2)
                
                return distance1 < distance2
            }
            .first
        
        
        print(closestShelter!)
                
        
        
//            .sorted(by: { shelter1, shelter2 in
//
//                let coordinatesShelter1 = CLLocationCoordinate2D(shelter1.address.latitude, shelter1.address.longitude)
//
//                let coordinatesShelter2 = CLLocationCoordinate2D(shelter2.address.latitude, shelter2.address.longitude)
//
//
//            })
        return closestShelter
    }
    
    // MARK: Distance in meters with CoreLocation Shelter points & current location
    func distanceBetweenWithCoreLocation(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> Double {
        
        let origin = CLLocation(latitude: origin.latitude, longitude: origin.longitude)
        let destination = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        
        return origin.distance(from: destination)
    }
    
    //    // MARK: Calculate distance between Shelter points & current location
    //
    //    func degreesToRadians(degrees: Double) -> Double {
    //        return degrees * Double.pi / 180
    //    }
    //
    //    func distanceInKmBetweenEarthCoordinates(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
    //
    //        let earthRadiusKm: Double = 6371
    //
    //        let dLat = degreesToRadians(degrees: lat2 - lat1)
    //        let dLon = degreesToRadians(degrees: lon2 - lon1)
    //
    //        let lat1 = degreesToRadians(degrees: lat1)
    //        let lat2 = degreesToRadians(degrees: lat2)
    //
    //        // MARK: Harvesine Formula
    //        // Square of half the chord length between the points
    //        let a = sin(dLat/2) * sin(dLat/2) +
    //        sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2)
    //
    //        // Angular distance in radians
    //        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    //
    //        return earthRadiusKm * c
    //    }
    
}
