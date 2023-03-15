//
//  MockRepository.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 18/2/23.
//

import Foundation
@testable import PetShelter

class RepositoryFake: Repository {
    
    
    
    let shelterCorrectIDFake = ShelterPointModel(
        id: "CorrectID",
        name: "Shelter Point 1",
        phoneNumber: "555-555-0001",
        address: Address(
            latitude: 40.4168,
            longitude: -3.7038),
        shelterType: .shelterPoint)

        
    let shelterWrongIDFake = ShelterPointModel(
        id: "WrongID",
        name: "Shelter Point 2",
        phoneNumber: "555-555-0001",
        address: Address(
            latitude: 40.4168,
            longitude: -3.7038),
        shelterType: .shelterPoint)

    
    var result: Result<[ShelterPointModel], NetworkError>
    
    
    init (result: Result<[ShelterPointModel], NetworkError> = .success([ShelterPointModel(
        id: "CorrectID",
        name: "Shelter Point 1",
        phoneNumber: "555-555-0001",
        address: Address(
            latitude: 40.4168,
            longitude: -3.7038),
        shelterType: .shelterPoint)])) {
        self.result = result
    }
    
    func fetchShelterPoints() async -> Result<[PetShelter.ShelterPointModel], PetShelter.NetworkError> {
        
        return result
    }
    
    func login(user: String, password: String) async -> Result<[String], PetShelter.NetworkError> {
        
        if (user == "user" && password == "password") {
            return .success(["Token","id"])
        }
        
        return .failure(.responseError)
    }
    
    func register(model: ShelterRegisterModel) async -> Result<RegisterState, NetworkError> {
        return model.name == "success" ? .success(.success) : .failure(.dataFormatting)
    }
    
  
    func getShelterDetail(userId: String) async -> Result<PetShelter.ShelterPointModel, PetShelter.NetworkError> {
        
        if (userId == "CorrectID") {
            return .success(shelterCorrectIDFake)
        } else {
            return .failure(.responseError)
        }
        
    }
    
    func updateShelter(userId: String, shelter: PetShelter.ShelterPointModel) async -> Result<PetShelter.ShelterPointModel, PetShelter.NetworkError> {
        if (userId == "CorrectID") {
            return .success(shelterCorrectIDFake)
        } else {
            return .failure(.responseError)
        }

    }
    
    func uploadPhoto(userId: String, imageData: Data, completion: @escaping (Result<[String : Any], PetShelter.NetworkError>) -> Void) {
        //TODO: - Test upload Photo
        
        if (userId == "CorrectID") {
            completion(.success(["Success Key": "Success Content"]))
        } else {
            completion(.failure(.responseError))
        }
        
    }
    
    
}

