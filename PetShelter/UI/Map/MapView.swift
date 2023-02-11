//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    @State var selectedShelter: ShelterPointModel?
    
    var body: some View {
        VStack {
            Header()
                .frame(height: 36)
                .padding()
            ZStack {
                Map(coordinates: $viewModel.locations){ selectedShelter in
                    self.selectedShelter = selectedShelter
                }
                .ignoresSafeArea()
                AidButton()
            }
        }.sheet(item: $selectedShelter, content: { option in
            ShelterDetailModal(shelter: option)
                .presentationDetents([.fraction(0.40), .large])
                .padding(.top, 20)
        })
        .onAppear {
            Task {
                await viewModel.getShelterPoints()
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

private func callNumber(phoneNumber: String) {
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application: UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
