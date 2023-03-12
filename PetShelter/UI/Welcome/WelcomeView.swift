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
                    .padding(.top,40)
                Spacer()
                    .frame(height: 190)
                
                HStack{
                    LottieView(lottieFile: "DogAnimation")
                         .frame(width: 160, height: 140)
                    Spacer()
                }
  
                PhysicPersonButton()

                Spacer()
            }

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
