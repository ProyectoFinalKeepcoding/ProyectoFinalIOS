//
//  ShelterButton.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import SwiftUI

struct ShelterButton: View {
    var body: some View {
        NavigationLink(destination: {
            LoginView()
        }, label: {
            Text("Soy un centro de acogida")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
        })
        .frame(width: 300)
        .padding()
        .background(Color.gray)
        .cornerRadius(16)
    }
}

struct ShelterButton_Previews: PreviewProvider {
    static var previews: some View {
        ShelterButton()
    }
}
