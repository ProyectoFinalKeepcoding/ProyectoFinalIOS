//
//  MockRepository.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 18/2/23.
//

import Foundation
@testable import PetShelter

class MockRepository: Repository {
    
    func fetchShelterPoints() async -> Result<[PetShelter.ShelterPointModel], PetShelter.NetworkError> {
        
        return .success([ShelterPointModel(
            id: "10000000-0000-0000-0000-000000000001",
            name: "Shelter Point 1",
            phoneNumber: "555-555-0001",
            address: Address(
                latitude: 40.4168,
                longitude: -3.7038),
            shelterType: .shelterPoint)])
    }
    
    func login(user: String, password: String) async -> Result<String, PetShelter.NetworkError> {
        
        if (user == "user" && password == "password") {
            return .success("Token")
        }
        
        return .failure(.responseError)
    }
    
    
}

