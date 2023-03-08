//
//  RepositoryTests.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 7/3/23.
//

import XCTest
@testable import PetShelter

final class RepositoryTests: XCTestCase {
    
    private var networkingFake: NetworkingFake!
    private var sut: Repository!
    

    override func setUpWithError() throws {
        networkingFake = NetworkingFake()
        sut = RepositoryImpl(urlSession: networkingFake)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchShelterPointsSuccess() async throws {
        
        //Given
        networkingFake.result = try .success(JSONEncoder().encode([shelterFake]))
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.fetchShelterPoints()
        
        //Then
        XCTAssertEqual(data, .success([shelterFake]) )
        XCTAssertNotEqual(data, .failure(.responseError))
        XCTAssertNotNil(data)
    }

}
