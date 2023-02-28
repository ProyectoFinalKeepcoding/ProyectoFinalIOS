//
//  RepositoryImpl.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/2/23.
//

import Foundation
import KeychainSwift

let server = "http://127.0.0.1:8080/api"

let ApiKey = "mWIwALVZo3a0evMfbUgkl/gLvRis1/w99To0AamBN+0="

struct HTTPMethods{
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
}

enum endpoints: String {
    case shelters = "/shelters"
    case login = "/auth/signin"
    case update = "/update"
}

class RepositoryImpl: Repository {
    
    private var urlSession = URLSession.shared
    
    private let keychain = KeychainSwift()
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError> {
        guard let url = URL(string: "\(server)\(endpoints.shelters.rawValue)") else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.setValue(ApiKey, forHTTPHeaderField: "ApiKey")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return .failure(.invalidCode)
            }
            
            let shelterPointModel = try JSONDecoder().decode([ShelterPointModel].self, from: data)
            return .success(shelterPointModel)
            
        } catch {
            print(error.localizedDescription)
            return .failure(.responseError)
        }
    }
    
    
    func login(user: String, password: String) async -> Result<[String], NetworkError> {
        
        guard let url = URL(string: "\(server)\(endpoints.login.rawValue)") else {
            return .failure(.invalidURL)
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            return .failure(.dataFormatting)
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        print("Base64 \(base64LoginString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get
        urlRequest.setValue(ApiKey, forHTTPHeaderField: "ApiKey")
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return .failure(.invalidCode)
            }
            
            let loginResponse = try JSONDecoder().decode([String].self, from: data)
            
            return .success(loginResponse)
            
        } catch {
            return .failure(.responseError)
        }
        
    }
    
    func register(model: RegisterModel) async {
        guard let url = URL(string: "\(server)/api/auth/signup") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(model)
        
        
    }
    
    func getShelterDetail(userId: String) async -> Result<ShelterPointModel, NetworkError> {
        
        guard let url = URL(string: "\(server)\(endpoints.shelters.rawValue)/\(userId)") else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        request.setValue(ApiKey, forHTTPHeaderField: "ApiKey")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return .failure(.invalidCode)
                
            }
            
            let shelterPointModel = try JSONDecoder().decode(ShelterPointModel.self, from: data)
            return .success(shelterPointModel)
            
        } catch {
            return .failure(.responseError)
        }
    }
    
    func updateShelter(userId: String, shelter: ShelterPointModel) async -> Result<ShelterPointModel, NetworkError> {
        
        guard let url = URL(string: "\(server)\(endpoints.update.rawValue)/\(userId)") else {
            return .failure(.invalidURL)
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        
        let body = ShelterUpdateBody(name: shelter.name, password: "", phoneNumber: shelter.phoneNumber, address: shelter.address, shelterType: shelter.shelterType, photoURL: shelter.photoURL)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        request.setValue(ApiKey, forHTTPHeaderField: "ApiKey")
        request.setValue("Bearer \(keychain.get("AccessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let json = String(data: data, encoding: .utf8)
                print("Fallo \(json)")
                return .failure(.invalidCode)
            }
            
            let shelterPointModel = try JSONDecoder().decode(ShelterPointModel.self, from: data)
            return .success(shelterPointModel)
            
        } catch {
            return .failure(.responseError)
        }
    }
    
}
