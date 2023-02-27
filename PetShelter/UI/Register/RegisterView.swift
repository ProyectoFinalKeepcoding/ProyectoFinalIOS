//
//  RegisterView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/2/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @State var userName = ""
    @State var password = ""
    @State var direction = ""
    @State var phone = ""
    @State var selectedOption: ShelterType = .particular
    
    var body: some View {
        
        VStack {
            Text("Crear una nueva cuenta")
                .bold()
                .font(.title2)
                .padding(.vertical, 32)
            VStack(alignment: .leading) {
                
                TextFieldBase(text: $userName, nameField: "Usuario", type: .textFieldBase)
                    .environmentObject(viewModel)
                TextFieldBase(text: $password, nameField: "Contraseña", type: .secureField)
                    .environmentObject(viewModel)
                TextFieldBase(text: $direction, nameField: "Dirección", type: .textFieldBase)
                    .onChange(of: direction) { newValue in
                        viewModel.autoCompletePlaces(place: newValue)
                        print(viewModel.predictions)
                    }
                    .environmentObject(viewModel)
                TextFieldBase(text: $phone, nameField: "Teléfono", type: .onlyNumbersField)
                    .environmentObject(viewModel)
            }
            .padding()
            
            Text("¿Que soy?")
            
            Picker("Tipo", selection: $selectedOption) {
                Text("Particular").tag(ShelterType.particular)
                Text("Ayuntamiento").tag(ShelterType.localGovernment)
                Text("Veterinario").tag(ShelterType.veterinary)
                Text("Refugio").tag(ShelterType.shelterPoint)
                Text("Tienda Kiwoko").tag(ShelterType.kiwokoStore)
            }
            .pickerStyle(.wheel)
            
            Button(action: {
                //
            }, label: {
                Text("Crear Cuenta")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 48)
                    .background(Color("RedKiwoko"))
                    .cornerRadius(4)
                    .shadow(radius: 6)
            })
            .padding()
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
