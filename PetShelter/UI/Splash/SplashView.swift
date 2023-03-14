//
//  SplashView.swift
//  PetShelter
//
//  Created by Roberto Rojo Sahuquillo on 16/2/23.
//


import SwiftUI

struct SplashView: View {
    
    @State private var animate = false
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            //Mandatory to fill the entire view
            Color.white
                .opacity(0.8)
                .ignoresSafeArea()
            
            if self.isActive {
                WelcomeView()
            } else {

                Circle()
                    .fill(CustomColor.redKiwoko)
                    .opacity(0.7)
                    .frame(width: 425, height: 425, alignment: .center)
                    .scaleEffect(animate ? 1.0 : 0.6)
                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: animate)

                Image("ShelterSplashViewLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .scaleEffect(animate ? 1.0 : 0.75)
                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: animate)
            }
        }

        .onAppear {
            DispatchQueue.main.async {
                self.animate = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .onDisappear{
            self.animate = false
        }
    }    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
