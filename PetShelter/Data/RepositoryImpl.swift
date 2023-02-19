//
//  RepositoryImpl.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/2/23.
//

import Foundation

let server = "http://127.0.0.1:8080"

class RepositoryImpl: Repository {
    
    private var urlSession = URLSession.shared
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError> {
        guard let url = URL(string: "http://127.0.0.1:8080/api/shelters") else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("mWIwALVZo3a0evMfbUgkl/gLvRis1/w99To0AamBN+0=", forHTTPHeaderField: "ApiKey")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return .failure(.invalidCode)
            }
            
            let shelterPointModel = try JSONDecoder().decode([ShelterPointModel].self, from: data)
            print(shelterPointModel)
            return .success(shelterPointModel)
            
        } catch {
            return .failure(.responseError)
        }
    }
    
    
    func login(user: String, password: String) async -> Result<String, NetworkError> {
        
        guard let url = URL(string: "http://127.0.0.1:8080/api/auth/signin") else {
            return .failure(.invalidURL)
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            return .failure(.dataFormatting)
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        print("Base64 \(base64LoginString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("mWIwALVZo3a0evMfbUgkl/gLvRis1/w99To0AamBN+0=", forHTTPHeaderField: "ApiKey")
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return .failure(.invalidCode)
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                return .failure(.tokenFormatError)
            }
            
            return .success(token)
            
        } catch {
            return .failure(.responseError)
        }
        
    }
    
    
}
