//
//  NetworkError.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import Foundation

enum NetworkError: Error {
    case responseError
    case invalidCode
    case invalidURL
    case dataFormatting
    case tokenFormatError
}
