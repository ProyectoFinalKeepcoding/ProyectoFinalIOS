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

enum ShelterType: Decodable, Encodable, CaseIterable {

    case particular
    case localGovernment
    case veterinary
    case shelterPoint   
    case kiwokoStore
    
    var description: String {
        switch self {
        case .veterinary:
            return "Veterinario"
        case .particular:
            return "Particular"
        case .shelterPoint:
            return "Centro de acogida"
        case .localGovernment:
            return "Ayuntamiento"
        case .kiwokoStore:
            return "Tienda kiwoko"
        }
    }
}

struct Address: Codable {
    let latitude: Double
    let longitude: Double
}
