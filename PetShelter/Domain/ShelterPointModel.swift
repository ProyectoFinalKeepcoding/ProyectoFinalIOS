//
//  ShelterPointModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation

struct ShelterPointModel: Decodable, Identifiable {
    let id: String
    var name: String
    var phoneNumber: String
    var address: Address
    var shelterType: ShelterType
    var photoURL: String?
}
