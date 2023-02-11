//
//  ShelterPointModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation

struct ShelterPointModel: Decodable, Identifiable {
    let id: String
    let name: String
    let phoneNumber: String
    let address: Address
    let shelterType: ShelterType
    var photoURL: String?
}
