//
//  DetailViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 25/2/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published var shelterDetail: ShelterPointModel = ShelterPointModel(id: "", name: "", phoneNumber: "", address: Address(latitude: 0.0, longitude: 0.0), shelterType: .shelterPoint)
    
    private var repository: Repository
    
    init(repository:Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func getShelterDetail(userId: String) async {
        
        let result = await repository.getShelterDetail(userId: userId)
        
        switch result {
        case .success(let shelterPoint):
            shelterDetail = shelterPoint
            print(shelterDetail)
        case .failure(let error):
            print(error)
        }
    }
}
