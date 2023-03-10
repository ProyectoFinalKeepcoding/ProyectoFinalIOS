//
//  Networking.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 8/3/23.
//

import Foundation

protocol Networking {
    func data (
        for request: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse)
    
    func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
}

extension Networking {
    
    func data (for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
    
}

extension URLSession: Networking {}
