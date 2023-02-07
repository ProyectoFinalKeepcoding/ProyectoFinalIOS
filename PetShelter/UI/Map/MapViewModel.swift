//
//  MapViewModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation
import GoogleMaps

final class MapViewModel: ObservableObject {
    let repository = RepositoryImpl()
    @Published var locations = [ShelterPointModel]()
    
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
    
}
