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
                Image(systemName: "cross.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(30)
            
        }
    }
}

//struct AidButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AidButton()
//    }
//}
