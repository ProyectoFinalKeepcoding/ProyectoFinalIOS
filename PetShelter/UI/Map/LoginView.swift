//
//  LoginView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 12/2/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @State private var user = ""
    @State private var password = ""
    
    var body: some View {
        
        VStack{
            Image("Title login")
                .padding(.top,100)
            
            Text("Ya tengo cuenta")
                .font(Font.custom("Moderat-Bold",size: 20))
                .padding(.top,60)
            
            TextField("Usuario", text: $user)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                .padding(.top,20)
            
            SecureField("Contraseña", text: $password)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                .padding(.top,20)
            
            Button {
                //TODO: - Función login
                Task{
                   await viewModel.login(user: user, password: password)
                }
            } label: {
                Text("Entrar")
                    .padding()
                    .foregroundColor(Color.white)
                    .font(Font.custom("Moderat-Medium", size: 16))
                    .frame(width: 200, height: 50)
                    .background(Color("Red Kiwoko"))
                    .cornerRadius(5)
            }.padding(.top, 20)
            
            Text("¿Has olvidado tu contraseña?")
                .font(Font.custom("Moderat-Medium",size: 18))
                .foregroundColor(Color("Red Kiwoko"))
                .padding(.top,10)
            
            Text("No tengo cuenta")
                .font(Font.custom("Moderat-Bold",size: 20))
                .padding(.top,60)
            
            NavigationLink {
                //MARK: - Ir al registro
                RegisterView()
            } label: {
                Text("Registrarme")
                    .font(Font.custom("Moderat-Bold",size: 20))
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
