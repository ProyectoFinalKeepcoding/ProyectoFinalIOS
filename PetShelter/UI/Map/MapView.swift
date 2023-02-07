//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack {
            Header()
                .frame(height: 36)
                .padding()
            ZStack {
                Map(coordinates: $viewModel.locations)
                    .ignoresSafeArea()
                AidButton()
            }
        }
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
