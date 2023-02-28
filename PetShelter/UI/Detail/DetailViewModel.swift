//
//  DetailViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 25/2/23.
//

import Foundation
import MapKit

final class DetailViewModel: NSObject, ObservableObject  {
    @Published var status = Status.none
    @Published var displayAlert = false
    
    @Published var shelterDetail: ShelterPointModel = ShelterPointModel(id: "", name: "", phoneNumber: "", address: Address(latitude: 0.0, longitude: 0.0), shelterType: .shelterPoint)
    
    @Published var addressResults: [AddressResult] = []
    @Published var searchableAddress = ""
    
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    private var repository: Repository
    
    init(repository:Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func getShelterDetail(userId: String) async {
        
        let result = await repository.getShelterDetail(userId: userId)
        
        switch result {
        case .success(let shelterPoint):
            shelterDetail = shelterPoint
            
            let location = CLLocation(latitude: shelterDetail.address.latitude, longitude: shelterDetail.address.longitude)
            convertCoordinatesToAddress(location: location)
            print(shelterDetail)
        case .failure(let error):
            print(error)
        }
    }
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return}
        localSearchCompleter.queryFragment = searchableText
    }
    
    func updateShelter() async {
        self.status = .loading
        convertAddressToCoordinates(address: searchableAddress)

    }
    
    func updateData() async {
        
        let result = await repository.updateShelter(userId: shelterDetail.id, shelter: shelterDetail)
        
        switch result {
        case .success(let shelterUpdated):
            self.status = .loaded
            displayAlert = true
            print(shelterUpdated)
        case .failure(let error):
            self.status = Status.error(error: "Error al actualizar datos")
            displayAlert = true
            print(error)
        }
    }
    
    func uploadImage(image: UIImage) async {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            return
        }
        
        repository.uploadPhoto(userId: shelterDetail.id, imageData: imageData, completion: { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        })        
        
    }
    
    func convertAddressToCoordinates(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location else {
                print("No location found")
                return
            }
            let latitud = location.coordinate.latitude
            let longitud = location.coordinate.longitude
            
            self.shelterDetail.address = Address(latitude: latitud, longitude: longitud)

            Task{
                await self.updateData()
            }
        }
    }
    
    func convertCoordinatesToAddress(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if error == nil {
                let pm = placemarks?[0]
                var addressString : String = ""
                
                guard let pm else {
                    return
                }
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.searchableAddress = addressString
                print("Address: \(addressString)")
            } else {
                print("Error transforming location")
            }
        }
    }
}

extension DetailViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            addressResults = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
