//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import Combine

/// View that shows a map with the user's location and a list of available Shelters around
/// - Parameters:
///    - selectedShelter: Variable to assign shelter to which is clicked
///    - isClosestPresented: Variable that determines if the nearest should be displayed
struct MapView: View {

    @ObservedObject var viewModel = MapViewModel()
    
    @State var selectedShelter: ShelterPointModel?

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
        /// Modal that is presented when selecting a shelter
        .sheet(item: $selectedShelter, content: { option in
            ShelterDetailModal(shelter: option)
                .presentationDetents([.fraction(0.40), .large])
                .padding(.top, 20)
        })
        /// Modal that is presented when trying to search for the nearest shelter
        .sheet(isPresented: $isClosestPresented, content: {
            
            ///Condition to display shelter if the default value or error text is not null
            if let closestShelter = viewModel.closestShelter {
                ShelterDetailModal(shelter: closestShelter)
                    .presentationDetents([.fraction(0.40), .large])
                    .padding(.top, 20)
            } else {
                Text("Error al cargar refugio")
                    .presentationDetents([.fraction(0.40)])
                    .font(Font.custom("Moderat-Medium",size: 18))
                    .foregroundColor(Color("RedKiwoko"))
                    .padding(.top, 20)
            }

        })
        
        .onAppear {
            Task {
                await viewModel.getShelterPoints()
            }
            
            viewModel.$modalPresented.sink { value in
                isClosestPresented = value
            }.store(in: &cancellables)
            
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


//Image("LogoLogin")
//    .padding(.bottom,20)
