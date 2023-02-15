//
//  LoginViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 13/2/23.
//

import Foundation

enum Status {
    case none, loading, loaded, error(error: String)
}

final class LoginViewModel: ObservableObject {
    @Published var status = Status.none
    
    @Published var hasError = false
    
    private var repository: Repository
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }    
    
    func login(user: String, password: String) async {
        self.status = .loading
        
        let result = await repository.login(user: user, password: password)
        
        switch result {
        case .success(let token):
            self.status = .loaded
            print(token)
        case .failure(let error):
            self.status = Status.error(error: "Usuario y/o Clave incorrectos")
            hasError = true
            print(error.localizedDescription)
        }
    }
}
