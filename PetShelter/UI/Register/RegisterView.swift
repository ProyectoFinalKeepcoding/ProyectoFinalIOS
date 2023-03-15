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
    @State var type: ShelterType = .veterinary
    @State var address: Address = Address(latitude: 0, longitude: 0)
    @State var addressContent = ""
    @State var addressSelected = false
    @State var isDisabled = false
    @State var popUpIsHidden = true
    
    var body: some View {
        
        ZStack {
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
                    ZStack {
                        TextFieldBase(text: $viewModel.searchableAddress, nameField: "Dirección", type: .textFieldBase)
                            .onChange(of: viewModel.searchableAddress) { query in
                                viewModel.searchAddress(query)
                            }
                            .environmentObject(viewModel)
                            .disabled(isDisabled)
                    }
                    TextFieldBase(text: $phone, nameField: "Teléfono", type: .onlyNumbersField)
                        .environmentObject(viewModel)
                        .zIndex(-1)
                }
                .padding()
                
                if !viewModel.searchableAddress.isEmpty && !addressSelected {
                    List(viewModel.searchResults, id: \.self) { result in
                        let address = viewModel.getAddresFormatted(address: result)
                        Text("\(address)")
                            .onTapGesture {
                                direction = address
                                viewModel.searchableAddress = address
                                addressSelected = true
                                viewModel.convertAddressToCoordinates(address: direction) { address in
                                    self.address = address ?? Address(latitude: 0, longitude: 0)
                                    isDisabled = true
                                }
                            }
                    }
                    .zIndex(1)
                    .padding(.top, -120)
                }
                Text("¿Que soy?")
                Picker("Tipo", selection: $type) {
                    Text("Particular").tag(ShelterType.particular)
                    Text("Ayuntamiento").tag(ShelterType.localGovernment)
                    Text("Veterinario").tag(ShelterType.veterinary)
                    Text("Refugio").tag(ShelterType.shelterPoint)
                    Text("Tienda Kiwoko").tag(ShelterType.kiwokoStore)
                }
                .pickerStyle(.wheel)
                .zIndex(-1)
                Button(action: {
                    
                    let model = ShelterRegisterModel(name: userName, password: password, phoneNumber: phone, address: address, shelterType: type)
                    Task {
                        if viewModel.isAvailableToSubmit(username: userName, password: password, phoneNumber: phone) {
                            await viewModel.registerUser(userData: model)
                            popUpIsHidden = false
                        } else {
                            viewModel.state = .error
                            popUpIsHidden = false
                        }
                        
                    }
                }, label: {
                    Text("Crear Cuenta")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 48)
                        .background(Color("RedKiwoko"))
                        .cornerRadius(4)
                        .shadow(radius: 6)
                })
                .padding()
                
            }
            switch viewModel.state {
            case .success:
                PopUpRegister(type: .success, isHidden: $popUpIsHidden)
            case .error:
                PopUpRegister(type: .failure, isHidden: $popUpIsHidden)
            case .none:
                EmptyView()
            case .loading:
                LoadingView()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
