//
//  ShelterRegisterModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation
struct ShelterRegisterModel: Decodable {
    let name: String
    let password: String
    let phoneNumber: String
    let address: Address
    let shelterType: ShelterType
    
}

enum ShelterType: String, Decodable {
    case veterinary
    case particular
    case shelterPoint
    case localGovernment
}

struct Address: Decodable {
    let latitude: Double
    let longitude: Double
}
