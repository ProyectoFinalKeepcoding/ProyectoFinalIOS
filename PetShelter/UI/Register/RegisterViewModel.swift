//
//  RegisterViewModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 23/2/23.
//

import Foundation
import GooglePlaces

class RegisterViewModel: ObservableObject {
    let placesClient = GMSPlacesClient()
    @Published var predictions: [GMSAutocompletePrediction] = []
    
    func validateUserName(userName: String) -> Bool {
        return userName.isEmpty ? false : true
    }
    
    func validatePassword(password: String) -> Bool {
        return password.count > 6 ? true : false
    }
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        return phoneNumber.count == 9 ? true : false
    }
    
    func autoCompletePlaces(place: String) {
        let filter = GMSAutocompleteFilter()
        filter.types = ["address"]
        placesClient.findAutocompletePredictions(fromQuery: place, filter: filter, sessionToken: nil) { results, error in
            self.predictions = results ?? []
        }
    }
}
