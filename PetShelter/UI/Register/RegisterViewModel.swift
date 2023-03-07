//
//  RegisterViewModel.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 23/2/23.
//

import Foundation
import GooglePlaces
import MapKit

class RegisterViewModel: NSObject, ObservableObject {
    
    private var repository: Repository
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var searchableAddress = ""
    @Published var state: RegisterState = .none
    
    func registerUser(userData: ShelterRegisterModel) async {
        state = .loading
        let result = await repository.register(model: userData)
        
        switch result {
        case .success(let success):
            state = success
            print("succes")
        case .failure(let error):
            state = .error
            print("\(error.localizedDescription)")
        }
    }
    
    func validateUserName(userName: String) -> Bool {
        return userName.isEmpty ? false : true
    }
    
    func validatePassword(password: String) -> Bool {
        return password.count > 6 ? true : false
    }
    
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        return phoneNumber.count == 9 ? true : false
    }
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return}
        localSearchCompleter.queryFragment = searchableText
    }
    
    func getAddresFormatted(address: MKLocalSearchCompletion) -> String {
        return !address.subtitle.isEmpty
        ? "\(address.title), \(address.subtitle)"
        : "\(address.title)"
    }
    
    func convertAddressToCoordinates(address: String, completionHandler: @escaping (Address?) -> Void) {
        let geoCoder = CLGeocoder()
        var coordinates = Address(latitude: 0, longitude: 0)
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else {
                completionHandler(nil)
                return
            }
            coordinates.latitude = location.coordinate.latitude
            coordinates.longitude = location.coordinate.longitude
            completionHandler(coordinates)
        }
    }
}

extension RegisterViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        print("\(searchResults)")
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

