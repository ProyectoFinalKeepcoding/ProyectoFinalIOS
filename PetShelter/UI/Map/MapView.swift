//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    @ObservedObject var locationManager = LocationManager()
    
    @State var selectedShelter: ShelterPointModel?
    
    var body: some View {
        VStack {
            Header()
                .frame(height: 36)
                .padding()
            ZStack {
                Map(locationManager: locationManager, coordinates: $viewModel.locations){ selectedShelter in
                    self.selectedShelter = selectedShelter
                }
                .ignoresSafeArea()
                AidButton(viewModel: viewModel)
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


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
