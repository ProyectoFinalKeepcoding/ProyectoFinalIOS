//
//  LoginViewModelTests.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 18/2/23.
//

import XCTest
@testable import PetShelter

final class LoginViewModelTests: XCTestCase {
    
    private var mockRepository: MockRepository!
    private var mockKeyChain: MockKeychain!
    private var sut: LoginViewModel!

    override func setUpWithError() throws {
        mockRepository = MockRepository()
        mockKeyChain = MockKeychain()
        sut = LoginViewModel(repository: mockRepository, keychain: mockKeyChain)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccessWithMockToken() async {
        
        //Given
        let user = "user"
        let password = "password"
        
        //When
        await sut.login(user: user, password: password)
        
        //Then
        XCTAssertEqual(sut.status, .loaded, "Login should be successful")
        XCTAssertEqual(mockKeyChain.savedToken, "Token", "Token in keychain should be the same retrieved")
    }
    
    func testLoginErrorEmptyFields() async {
        
        //Given
        let user = ""
        let password = ""
        
        //When
        await sut.login(user: user, password: password)
        
        //Then
        XCTAssertEqual(sut.status, .error(error: "Debe completar todos los campos"), "Status should be this error")
    }
    
    func testLoginErrorWithInvalidData() async {
        //Given
        let user = "abcds"
        let password = "asdasdf"
        
        //When
        await sut.login(user: user, password: password)
        
        //Then
        XCTAssertEqual(sut.status, .error(error: "Usuario y/o Clave incorrectos"), "Status should be this error")
    }

}
