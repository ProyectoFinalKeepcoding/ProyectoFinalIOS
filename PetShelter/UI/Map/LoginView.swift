//
//  LoginView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 12/2/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var user = ""
    @State private var password = ""
    
    var body: some View {
        
        VStack{
            Image("Title login")
                .padding(.top,100)
            
            Text("Ya tengo cuenta")
                .font(.system(size: 20, weight: .bold))
                .padding(.top,60)
            
            TextField("Usuario", text: $user)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                .padding(.top,20)
            
            TextField("Contraseña", text: $password)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                .padding(.top,20)
            
            Button {
                //TODO: - Función login
            } label: {
                Text("Entrar")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color("Red Kiwoko"))
                    .cornerRadius(5)
            }.padding(.top, 20)
            
            Text("¿Has olvidado tu contraseña?")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color("Red Kiwoko"))
                .padding(.top,10)
            
            Text("No tengo cuenta")
                .font(.system(size: 20, weight: .bold))
                .padding(.top,60)
            
            NavigationLink {
                //MARK: - Ir al registro
                RegisterView()
            } label: {
                Text("Registrarme")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Red Kiwoko"))
            }.padding(.top,5)
            
            Spacer()
            
        }
        .padding([.leading, .trailing], 20)
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
