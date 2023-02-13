//
//  LoginViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 13/2/23.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    private var repository: Repository
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }    
    
    func login(user: String, password: String) async {
        
        let result = await repository.login(user: user, password: password)
        
        switch result {
        case .success(let token):
            print(token)
        case .failure(let error):
            print(error)
        }
    }
}
