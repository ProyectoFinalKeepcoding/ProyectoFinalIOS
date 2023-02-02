//
//  ContentView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                DogAnimation(lottieFile: "DogAnimation")
                    .frame(width: 300, height: 200)
                Button {
                    //
                } label: {
                    Text("Soy un centro de acogida")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: 300)
                .padding()
                .background(Color.gray)
                .cornerRadius(16)
                Spacer()
                    .frame(height: 32)
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
                
                Spacer()
            }
            .padding()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
