//
//  DetailViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 25/2/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    private var repository: Repository
    
    init(repository:Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func getShelterDetail(userId: String) async {
        
    }
}
