//
//  AidButton.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI


struct AidButton: View {
    @ObservedObject var viewModel: MapViewModel
    
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                //TODO: Search closest location & show its modal
                viewModel.onClickClosestShelter()
            } label: {
                Text("Refugio más cercano")
            }
            .padding()
            .scaledToFit()
            .frame(height: 120)
            .foregroundColor(Color.white)
            .font(Font.custom("Moderat-Medium", size: 22))
            .fontWeight(.bold)
            .background(Color("RedKiwoko"))
            .cornerRadius(5)
            
        }
    }
}

struct AidButton_Previews: PreviewProvider {
    static var previews: some View {
        AidButton(viewModel: MapViewModel())
    }
}
