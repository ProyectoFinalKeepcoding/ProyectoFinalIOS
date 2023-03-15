//
//  MapViewModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation
import GoogleMaps
import SwiftUI
import Combine

/// ViewModel associated to MapView
/// - Parameters:
///    - locations: list of shelter points downloaded from API Service
///    - modalPresented: Variable which determines if modal of closest shelter should be presented
///    - closestShelter: Model thant contains data of closest Shelter from user´s location
final class MapViewModel: ObservableObject {
    private var repository: Repository
    
    @Published var status = Status.none
    @Published var locations = [ShelterPointModel]()
    
    
    @Published var modalPresented: Bool = false
    @Published var closestShelter: ShelterPointModel?
    
    var cancellable: AnyCancellable?

    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    /// Gets list of shelters downloaded from server
    func getShelterPoints() async {
        let result = await repository.fetchShelterPoints()
        
        switch result {
        case .success(let points):
            locations = points
            
        case .failure(let error):
            print(error)
            status = .error(error: error.localizedDescription)
        }
    }
        

    /// Gets the closest shelter based on user´s location , shows a modal with the detail and animates the camera to its position
    func onClickClosestShelter() {
        //TODO: #1 Get Closest Shelter
        let closestShelter = getClosestShelter()

        // TODO: #2 Activate Modal Shelter
        modalPresented = true
        // TODO: #3 Zoom camera to this Shelter
        self.closestShelter = closestShelter
    }
    
    /// Gets closest Shelter from current location
    func getClosestShelter() -> ShelterPointModel? {
        
        //MARK: #1 Get origin coordiantes
        let origin = CLLocationCoordinate2D(latitude: Map.locationManager.latitude, longitude: Map.locationManager.longitude )
                
        //MARK: #2 init closestShelter

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
    
                
        return closestShelter
    }
    
    
    /// Calculates distance in meters with CoreLocation Shelter points & current location
    /// - Parameters:
    ///   - origin: origin point
    ///   - destination: destination point
    /// - Returns: Double with the distance value
    func distanceBetweenWithCoreLocation(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> Double {
        
        let origin = CLLocation(latitude: origin.latitude, longitude: origin.longitude)
        let destination = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        
        return origin.distance(from: destination)
    }
    
}
