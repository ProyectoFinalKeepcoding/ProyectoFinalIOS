//
//  RegisterModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 23/2/23.
//

import Foundation

struct RegisterModel: Encodable {
    let name: String
    let password: String
    let address: Address
    let shelterType: ShelterType
}
