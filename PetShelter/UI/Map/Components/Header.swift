//
//  Header.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 40))
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Logo")
                .font(.title)
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
