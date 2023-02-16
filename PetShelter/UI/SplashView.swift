//
//  SplashView.swift
//  PetShelter
//
//  Created by Roberto Rojo Sahuquillo on 16/2/23.
//


import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.red
                .opacity(0.9)
            .ignoresSafeArea()
            
            if self.isActive {
                WelcomeView()
            } else {
//                Rectangle()
//                    .background(Color.red)
//
                Image("ShelterSplashViewLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }

        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
//        Color.red
//            .opacity(0.3)
//        .background(Color.red)
//        .opacity(0.3)
    }
       
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
