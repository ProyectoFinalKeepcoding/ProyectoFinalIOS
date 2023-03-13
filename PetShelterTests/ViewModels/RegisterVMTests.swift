//
//  RegisterVMTests.swift
//  PetShelterTests
//
//  Created by Francisco Javier Alarza Sanchez on 11/3/23.
//

import XCTest
import MapKit
@testable import PetShelter

final class RegisterVMTests: XCTestCase {
    var sut: RegisterViewModel!

    override func setUpWithError() throws {
        sut = RegisterViewModel(repository: RepositoryFake())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testRegisterUserSuccess() async {
        // Given
        let model = ShelterRegisterModel(name: "success", password: "", phoneNumber: "", address: Address(latitude: 0, longitude: 0), shelterType: .particular)
        // When
        await sut?.registerUser(userData: model)
        // Then
        XCTAssertEqual(sut?.state, .success)
    }
    
    func testRegisterUserFailure() async {
        // Given
        let model = ShelterRegisterModel(name: "", password: "", phoneNumber: "", address: Address(latitude: 0, longitude: 0), shelterType: .particular)
        // When
        await sut?.registerUser(userData: model)
        // Then
        XCTAssertEqual(sut?.state, .error)
    }
    
    func testValidateUserName() {
        // Given
        let usernameOK = "Fran"
        let usernameKO = ""
        // When
        let isValidateOk = sut.validateUserName(userName: usernameOK)
        let isValidateKo = sut.validateUserName(userName: usernameKO)
        // Then
        XCTAssertFalse(isValidateKo)
        XCTAssertTrue(isValidateOk)
    }
    
    func testValidatePassword() {
        // Given
        let passwordOK = "1234567"
        let passwordKO = ""
        // When
        let isValidateOk = sut.validatePassword(password: passwordOK)
        let isValidateKo = sut.validatePassword(password: passwordKO)
        // Then
        XCTAssertFalse(isValidateKo)
        XCTAssertTrue(isValidateOk)
    }
    
    func testValidatePhone() {
        // Given
        let phoneOK = "677888666"
        let phoneKO = ""
        // When
        let isValidateOk = sut.validatePhoneNumber(phoneNumber: phoneOK)
        let isValidateKo = sut.validatePhoneNumber(phoneNumber: phoneKO)
        // Then
        XCTAssertFalse(isValidateKo)
        XCTAssertTrue(isValidateOk)
    }
    
    func testSearchAddress() {
        // Given

        // When
        let result: () = sut.searchAddress("Roma")
        let resultEmpty: () = sut.searchAddress("")
        // Then
        XCTAssertNotNil(result)
        XCTAssertNotNil(resultEmpty)
    }
    
    func testAddresFormatted() {
        // Given
        let searchResult = MKLocalSearchCompletion()
        // When
        let result = sut.getAddresFormatted(address: searchResult)
        // Then
        XCTAssertTrue(result.isEmpty)
    }
    
    func testConvertAddressToCoordinates() {
        // Given
        let address = "Madrid"
        var coordinates = Address(latitude: 0, longitude: 0)
        // When
        sut.convertAddressToCoordinates(address: address) { addressResult in
            if let addressResult {
                coordinates = addressResult
            } else {
                coordinates = Address(latitude: 0, longitude: 0)
            }
        }
        // Then
        XCTAssertTrue(coordinates.latitude == 0)
        XCTAssertTrue(coordinates.longitude == 0)
    }
    
    func testValidateToSubmit() {
        // Given
        
        // When
        let isValidateOk = sut.isAvailableToSubmit(username: "Fran", password: "1234567", phoneNumber: "678998778")
        let isValidateKo = sut.isAvailableToSubmit(username: "", password: "", phoneNumber: "")
        // Then
        XCTAssertFalse(isValidateKo)
        XCTAssertTrue(isValidateOk)
    }

}
