//
//  RemoteDataSource.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 3/2/23.
//

import Foundation

protocol RemoteDataSource {
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError>
}
