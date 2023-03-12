//
//  PhysicPersonButton.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import SwiftUI

struct PhysicPersonButton: View {
    var body: some View {
        NavigationLink(destination: {
            MapView()
        }, label: {
            Text("He encontrado una mascota")
                .font(Font.custom("Moderat-Medium", size: 24))
                .padding(.vertical, 10)
                .lineSpacing(10)
                .foregroundColor(.white)
        })
        .frame(width: 310)
        .padding()
        .background(Color("RedKiwoko"))
        .cornerRadius(5)
    }
}

struct PhysicPersonButton_Previews: PreviewProvider {
    static var previews: some View {
        PhysicPersonButton()
    }
}
