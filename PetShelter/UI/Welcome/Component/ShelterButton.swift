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
                .font(Font.custom("Moderat-Medium", size: 24))
                .padding(.vertical, 10)
                .lineSpacing(10)
                .foregroundColor(Color("RedKiwoko"))
        })
        .frame(width: 310)
        .padding()
        .background(Color.white)
        .cornerRadius(5)
    }
}

struct ShelterButton_Previews: PreviewProvider {
    static var previews: some View {
        ShelterButton()
    }
}
