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

                ShelterButton()
                Spacer()
                    .frame(height: 180)
                
                HStack{
                    LottieView(lottieFile: "DogAnimation")
                         .frame(width: 160, height: 200)
                    Spacer()
                }
                
                PhysicPersonButton()
                Spacer()
            }
            
            .padding()
            .background(
                Image(decorative: "Welcome")
                    .resizable()
            ).ignoresSafeArea()

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
