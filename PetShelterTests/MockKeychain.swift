//
//  MockKeychain.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 19/2/23.
//

import Foundation
import KeychainSwift


class MockKeychain: KeychainSwift {
    
    var savedToken: String?
    
    
    override func set(_ value: String, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        savedToken = value
        return true
    }
}
