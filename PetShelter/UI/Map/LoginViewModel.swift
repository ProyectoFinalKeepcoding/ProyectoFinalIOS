//
//  LoginViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 13/2/23.
//

import Foundation
import KeychainSwift

enum Status: Equatable {
    case none, loading, loaded, error(error: String)
}

/// ViewModel class for Login
/// - Parameters:
///    - status: Variants of the status from the start to the completion of the login process with success or failure
///    - hasError: Indicates if there is an error in the login to show an alert message
///    - navigateToDetail: Perform navigation when set to true
///    - userId: Id of the user obtained when logging in to go to the detail view
final class LoginViewModel: ObservableObject {
    @Published var status = Status.none
    
    @Published var hasError = false
    
    @Published var navigateToDetail = false
    
    @Published var userId = ""
    
    private var repository: Repository
    private var keychain: KeychainSwift
    
    init(repository: Repository = RepositoryImpl(),
         keychain: KeychainSwift = KeychainSwift()) {
        self.repository = repository
        self.keychain = keychain
    }    
    
    /// Makes call to login method in repository and updates variables with result
    /// - Parameters:
    ///   - user: User´s name
    ///   - password: User´s password
    func login(user: String, password: String) async {
        
        guard !user.isEmpty, !password.isEmpty else {
            self.status = .error(error: "Debe completar todos los campos")
            hasError = true
            return
        }
        self.status = .loading
        
        let result = await repository.login(user: user, password: password)
        
        switch result {
        case .success(let loginResponse):
            self.keychain.set(loginResponse[0], forKey: "AccessToken")
            self.userId = loginResponse[1]            
            self.status = .loaded
            navigateToDetail = true
        case .failure(let error):
            self.status = Status.error(error: "Usuario y/o Clave incorrectos")
            hasError = true
            print(error.localizedDescription)
        }
    }
}
