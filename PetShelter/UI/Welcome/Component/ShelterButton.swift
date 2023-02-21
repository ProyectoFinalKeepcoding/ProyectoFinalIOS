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
            Text("Puedo acoger a una mascota")
                .font(Font.custom("Moderat-Medium", size: 25))
                .bold()
                .foregroundColor(Color("RedKiwoko"))
        })
        .frame(width: 300)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct ShelterButton_Previews: PreviewProvider {
    static var previews: some View {
        ShelterButton()
    }
}
