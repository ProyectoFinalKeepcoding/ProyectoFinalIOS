//
//  DetailViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 25/2/23.
//

import Foundation
import MapKit

final class DetailViewModel: NSObject, ObservableObject  {
    
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
            print(shelterDetail)
        case .failure(let error):
            print(error)
        }
    }
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return}
        localSearchCompleter.queryFragment = searchableText
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
