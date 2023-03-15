//
//  DetailVMTests.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 4/3/23.
//

import XCTest
@testable import PetShelter
import CoreLocation

final class DetailVMTests: XCTestCase {
    
    private var mockRepository: RepositoryFake!
    private var sut: DetailViewModel!

    override func setUpWithError() throws {
        mockRepository = RepositoryFake()
        sut = DetailViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetShelterDetailSuccess() async {
        //Given
        let userID = "CorrectID"
        
        //When
       await sut.getShelterDetail(userId: userID)
        
        //Then
        XCTAssertEqual(sut.shelterDetail.name, mockRepository.shelterCorrectIDFake.name, "Shelter should be the same")
    }

    func testGetShelterDetailError() async {
        //Given
        let userID = "WrongID"
        
        //When
       await sut.getShelterDetail(userId: userID)
        
        //Then
        XCTAssertEqual(sut.status,.error(error: NetworkError.responseError.localizedDescription), "Status should be this error")
    }
    
    func testUpdateDataSuccess() async {
        //Given
        sut.shelterDetail = mockRepository.shelterCorrectIDFake
        
        //When
        await sut.updateData()
        
        //Then
        XCTAssertEqual(sut.status, .loaded, "Status should be loaded")
    }
    
    func testUpdateDataError() async {
        //Given
        sut.shelterDetail = mockRepository.shelterWrongIDFake
        
        //When
        await sut.updateData()
        
        //Then
        XCTAssertEqual(sut.status, .error(error: "Error al actualizar datos"), "Status should be this error")
    }
    
    
    func testUpdateShelterErrorImage() async {
        //Given
        sut.shelterDetail = mockRepository.shelterWrongIDFake
        let image = UIImage(systemName: "xmark.circle")!
        
        //When
        await sut.updateShelter(image: image)
        
        //Then
        XCTAssertEqual(sut.status, .error(error: "Error al subir imagen"),"Status should be this error")
    }
    
    func testConvertAddressToCoordinates() {
        //Given
        let address = "Puerta del Sol"
        
        //When
        sut.convertAddressToCoordinates(address: address)
        
        //Then
        XCTAssertEqual(sut.shelterDetail.address.latitude, 40.41691, accuracy: 0.002, "Address should convert to this coordinate")
    }
    
    func testSearchAddress() {
        //Given
        let searchableText = "Address"
        
        //When
        sut.searchAddress(searchableText)
        
        //Then
        XCTAssertEqual(sut.localSearchCompleter.queryFragment, searchableText, "Search text should be the same")
    }

}
