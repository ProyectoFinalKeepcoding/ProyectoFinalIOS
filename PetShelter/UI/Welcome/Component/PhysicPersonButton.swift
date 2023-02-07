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
            Text("Soy un rescatador")
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

struct PhysicPersonButton_Previews: PreviewProvider {
    static var previews: some View {
        PhysicPersonButton()
    }
}
