//
//  RemoteDataSourceImpl.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/2/23.
//

import Foundation

class RemoteDataSourceImpl: RemoteDataSource {
    
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError> {
        guard let url = URL(string: "http://127.0.0.1:8080/api/shelters") else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("mWIwALVZo3a0evMfbUgkl/gLvRis1/w99To0AamBN+0=", forHTTPHeaderField: "ApiKey")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let shelterPointModel = try JSONDecoder().decode([ShelterPointModel].self, from: data)
            return .success(shelterPointModel)
        } catch {
            return .failure(.responseError)
        }
    }
    
}
