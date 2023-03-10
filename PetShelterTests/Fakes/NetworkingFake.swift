//
//  NetworkingFake.swift
//  PetShelterTests
//
//  Created by Joaquín Corugedo Rodríguez on 8/3/23.
//

import Foundation
@testable import PetShelter

class NetworkingFake: Networking {
    
    var result = Result<Data, NetworkError>.success(Data())
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let response else {
          return  try (result.get(), URLResponse())
        }
        return try (result.get(), response)
    }
    
    func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        return URLSessionUploadTaskFake {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
    
}

class URLSessionUploadTaskFake: URLSessionUploadTask {
    private let closure: () -> Void
    
    init( closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
