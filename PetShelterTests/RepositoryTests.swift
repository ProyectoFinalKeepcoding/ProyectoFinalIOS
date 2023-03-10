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
        XCTAssertNotNil(data)
        XCTAssertEqual(data, .success([shelterFake]))

    }
    
    func testFetchShelterPointsFailWithErrorCode() async throws {
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.fetchShelterPoints()
        
        //Then
        XCTAssertEqual(data, .failure(.invalidCode))
    }
    
    func testFetchShelterPointsFailWithError() async throws {
        
        //Given
        networkingFake.result = .failure(.responseError)
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.fetchShelterPoints()
        
        //Then
        XCTAssertEqual(data, .failure(.responseError))
    }
    
    func testLoginSuccess() async throws {
        
        //Given
        networkingFake.result = try .success(JSONEncoder().encode(fakeLoginResponse))
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.login(user: "", password: "")
        
        //Then
        XCTAssertEqual(data, .success(fakeLoginResponse))
        
    }
    
    func testLoginFailWithErrorCode() async throws {
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.login(user: "", password: "")
        
        //Then
        XCTAssertEqual(data, .failure(.invalidCode))
        
    }
    
    func testLoginFailWithError() async throws {
        
        //Given
        networkingFake.result = .failure(.responseError)
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.login(user: "", password: "")
        
        //Then
        XCTAssertEqual(data, .failure(.responseError))
        
    }
    
    func testRegisterSuccess() async throws {
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.register(model: shelterRegisterFake)
        
        //Then
        XCTAssertEqual(data, .success(.success))
    }
    
    func testRegisterFailWithErrorCode() async throws {
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.register(model: shelterRegisterFake)
        
        //Then
        XCTAssertEqual(data, .failure(.invalidCode))
    }
       
    func testRegisterFailWithError() async throws {
        
        //Given
        networkingFake.result = .failure(.responseError)
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.register(model: shelterRegisterFake)
        
        //Then
        XCTAssertEqual(data, .failure(.responseError))
    }
    
    func testGetShelterDetailSuccess() async throws {
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        networkingFake.result = try .success(JSONEncoder().encode(shelterFake))
        
        //When
        let data = await sut.getShelterDetail(userId: "")
        
        //Then
        XCTAssertEqual(data, .success(shelterFake))
        
    }
    
    func testGetShelterDetailFailWithErrorCode() async throws {
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.getShelterDetail(userId: "")
        
        //Then
        XCTAssertEqual(data, .failure(.invalidCode))
    }
    
    func testGetShelterDetailFailWithError() async throws {
        //Given
        networkingFake.result = .failure(.responseError)
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.getShelterDetail(userId: "")
        
        //Then
        XCTAssertEqual(data, .failure(.responseError))
    }
    
    func testUpdateShelterSuccess() async throws {
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        networkingFake.result = try .success(JSONEncoder().encode(shelterFake))
        
        //When
        let data = await sut.updateShelter(userId: "", shelter: shelterFake)
        
        //Then
        XCTAssertEqual(data, .success(shelterFake))
        
    }
    
    func testUpdateShelterFailWithErrorCode() async throws {
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.updateShelter(userId: "", shelter: shelterFake)
        
        //Then
        XCTAssertEqual(data, .failure(.invalidCode))
        
    }
    
    func testUpdateShelterFailWithError() async throws {
        //Given
        networkingFake.result = .failure(.responseError)
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        let data = await sut.updateShelter(userId: "", shelter: shelterFake)
        
        //Then
        XCTAssertEqual(data, .failure(.responseError))
        
    }
    
    func testUploadPhotoSuccess() async throws {
        var error: NetworkError?
        var response: [String: Any]?
        
        //Given
        networkingFake.error = nil
        networkingFake.data = try JSONEncoder().encode(fakeUploadImageResponse)
        
        //When
        sut.uploadPhoto(userId: "userId", imageData: Data()) { result in
            
            switch result {
            case .success(let data):
                response = data
            case .failure(let networkError):
                error = networkError
            }
        }
        
        //Then
        XCTAssertEqual(response as! [String : String] , fakeUploadImageResponse)
        XCTAssertNil(error, "There should be no error")
        
    }
    
    func testUploadPhotoError() {
        var error: NetworkError?
        var response: [String: Any]?
        
        //Given
        networkingFake.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        //When
        sut.uploadPhoto(userId: "userId", imageData: Data()) { result in
            
            switch result {
            case .success(let data):
                response = data
            case .failure(let networkError):
                error = networkError
            }
        }
        
        //Then
        XCTAssertEqual(error, .responseError)
        XCTAssertNil(response, "Response should be nil")
    }
    
    

}
