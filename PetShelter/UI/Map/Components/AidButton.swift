//
//  AidButton.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct AidButton: View {
    var body: some View {
        VStack {
            Spacer()
            Button {
                //
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

struct AidButton_Previews: PreviewProvider {
    static var previews: some View {
        AidButton()
    }
}
