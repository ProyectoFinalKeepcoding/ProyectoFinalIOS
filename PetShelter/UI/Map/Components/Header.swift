//
//  Header.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("LogoLogin")
                .padding(.bottom,20)
            Spacer()
            Image("Title login")
                .resizable()
                .frame(width: 250, height: 48)
            Spacer()
        }
        .padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
