//
//  MapVMTests.swift
//  PetShelterTests
//
//  Created by Roberto Rojo Sahuquillo on 15/3/23.
//

import XCTest
@testable import PetShelter
import CoreLocation

final class MapVMTests: XCTestCase {
    
    private var mockRepository: RepositoryFake!
    private var sut: MapViewModel!
    
    let shelterCorrectIDFake = ShelterPointModel(
        id: "CorrectID",
        name: "Shelter Point 1",
        phoneNumber: "555-555-0001",
        address: Address(
            latitude: 40.4168,
            longitude: -3.7038),
        shelterType: .shelterPoint)

    override func setUpWithError() throws {
        mockRepository = RepositoryFake()
        sut = MapViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetSheltersSuccess() async {
        //Given
        mockRepository.result = .success([shelterCorrectIDFake])
        
        //When
       await sut.getShelterPoints()
        
        //Then
        XCTAssertEqual(sut.locations.first?.name, mockRepository.shelterCorrectIDFake.name, "Shelter should be the same")
    }

    func testGetSheltersError() async {
        //Given
        mockRepository.result = .failure(.responseError)
        
        //When
        await sut.getShelterPoints()

        //Then
        XCTAssertEqual(sut.status,.error(error: NetworkError.responseError.localizedDescription), "Status should be this error")
    }
    
    func testClosestShelter() {
        //Given
        sut.locations = [
            ShelterPointModel(
            id: "ID1",
            name: "Shelter Point 1",
            phoneNumber: "555-555-0001",
            address: Address(
                latitude: 40.4168,
                longitude: -3.7038),
            shelterType: .shelterPoint),
                ShelterPointModel(
                id: "ID2",
                name: "Shelter Point 2",
                phoneNumber: "555-555-0002",
                address: Address(
                    latitude: 40.4268,
                    longitude: -3.7038),
                shelterType: .shelterPoint)
        ]
        
        Map.locationManager.location = CLLocation(latitude: 40.4568, longitude: -3.8038)
        
        //When
        let closestShelter = sut.getClosestShelter()
        
        //Then
        XCTAssertEqual(sut.locations[1], closestShelter, "Shelter should be the same")
    }
}
