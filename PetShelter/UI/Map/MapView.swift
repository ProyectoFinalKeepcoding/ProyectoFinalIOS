//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import Combine

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    
    /// Variable para asignar shelter al que se hace click
    @State var selectedShelter: ShelterPointModel?
    /// Variable que determina si se debe mostrar el más cercano
    @State var isClosestPresented: Bool = false
    
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            Header()
                .frame(height: 36)
                .padding()
            ZStack {
                Map(viewModel: viewModel,coordinates: $viewModel.locations){ selectedShelter in
                    self.selectedShelter = selectedShelter
                }
                .ignoresSafeArea()
                AidButton(viewModel: viewModel)
            }
        }
        /// Modal que se presenta al seleccionar un shelter
        .sheet(item: $selectedShelter, content: { option in
            ShelterDetailModal(shelter: option)
                .presentationDetents([.fraction(0.40), .large])
                .padding(.top, 20)
        })
        /// Modal que se presenta al intentar buscar el shelter más cercano
        .sheet(isPresented: $isClosestPresented, content: {
            ShelterDetailModal(shelter: viewModel.closestShelter!)
                .presentationDetents([.fraction(0.40), .large])
                .padding(.top, 20)
        })
        
        .onAppear {
            Task {
                await viewModel.getShelterPoints()
            }
            
            viewModel.$modalPresented.sink { value in
                isClosestPresented = value
            }.store(in: &cancellables)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
