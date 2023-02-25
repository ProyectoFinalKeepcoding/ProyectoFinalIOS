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
        
        
        NavigationView {
            VStack{
                HStack(alignment: .center){
                    Image("LogoLogin")
                        .padding(.bottom,20)
                    Image("Title login")
                }.padding(.top,75)
                
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
                        
                        if viewModel.status == .loaded {
                            user = ""
                            password = ""
                        }
                    }
                } label: {
                    Text("Entrar")
                        .padding()
                        .foregroundColor(Color.white)
                        .font(Font.custom("Moderat-Bold", size: 18))
                        .frame(width: 200, height: 50)
                        .background(Color("RedKiwoko"))
                        .cornerRadius(5)
                }.padding(.top, 20)
                    .shadow(radius: 10.0, x:20, y:10)
                
                Text("¿Has olvidado tu contraseña?")
                    .font(Font.custom("Moderat-Medium",size: 18))
                    .foregroundColor(Color("RedKiwoko"))
                    .padding(.top,10)
                
                Text("No tengo cuenta")
                    .font(Font.custom("Moderat-Bold",size: 20))
                    .padding(.top,50)
                
                NavigationLink {
                    //MARK: - Ir al registro
                    RegisterView()
                } label: {
                    Text("Registrarme")
                        .font(Font.custom("Moderat-Bold",size: 20))
                        .foregroundColor(Color("RedKiwoko"))
                }.padding(.top,5)
                
                switch viewModel.status {
                    
                case .loading:
                    ProgressView()
                        .scaleEffect(2)
                        .padding(.top,10)
                    
                default:
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            .padding([.leading, .trailing], 20)
            .alert(isPresented: $viewModel.hasError) {
                
                if case let .error(message) = viewModel.status {
                    return Alert(title: Text("Error"),
                                 message: Text(message))
                }
                
                return Alert(title: Text(""))
            }
            
        }.navigationDestination(
            isPresented: $viewModel.navigateToDetail) {
                DetailView(userId: viewModel.userId)
            }
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

