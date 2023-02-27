//
//  UpdateRequestBody.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 27/2/23.
//

import Foundation


struct ShelterUpdateBody: Encodable {
    let name: String
    let password: String
    let phoneNumber: String
    let address: Address
    let shelterType: ShelterType
    let photoURL: String?
}
