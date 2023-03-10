//
//  ShelterPointModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation

struct ShelterPointModel: Codable, Identifiable , Equatable {
    static func == (lhs: ShelterPointModel, rhs: ShelterPointModel) -> Bool {
        return lhs.id == rhs.id
    }
    

    let id: String
    var name: String
    var phoneNumber: String
    var address: Address
    var shelterType: ShelterType
    var photoURL: String?
}
