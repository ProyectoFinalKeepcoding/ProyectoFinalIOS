//
//  FakeDataVariables.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 8/3/23.
//

import Foundation
@testable import PetShelter

let shelterRegisterFake = ShelterRegisterModel(
    name: "name",
    password: "password",
    phoneNumber: "555-555-0001",
    address: Address(
        latitude: 40.4168,
        longitude: -3.7038),
    shelterType: .shelterPoint)

let shelterFake = ShelterPointModel(
    id: "ID",
    name: "Shelter Point 1",
    phoneNumber: "555-555-0001",
    address: Address(
        latitude: 40.4168,
        longitude: -3.7038),
    shelterType: .shelterPoint
)

let fakeLoginResponse = ["Token", "UserId"]

let fakeUploadImageResponse = ["Key" : "Value"]
