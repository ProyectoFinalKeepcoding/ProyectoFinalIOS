//
//  DetailView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 16/2/23.
//

import SwiftUI
import KeychainSwift

struct DetailView: View {
    
    @StateObject var viewModel = DetailViewModel()
    
    var userId: String
    
    @State var addressSelected = true
    @State var addressContent = ""
    
    @State var isFirstLoaded = true
    
    @FocusState var isFocusOn: Bool
    
    var shelterTypes = ShelterType.allCases
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var isImageSelected = false
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center, spacing: 5){
                
                Spacer()
                
                TextField("Nombre",text: $viewModel.shelterDetail.name) {
                    
                }.multilineTextAlignment(.center)
                    .font(Font.custom("Moderat-Bold",size: 22))
                    .focused($isFocusOn)
                
                Button {
                    isFocusOn.toggle()
                } label: {
                    Image("pencil")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
            }
            .padding(.top, 20)
            
            ZStack{
                if (isImageSelected) {
                    Image(uiImage: self.image)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .aspectRatio(contentMode:.fit)
                        .cornerRadius(10)
                    
                } else {
                    AsyncImage(url: URL(string: "\(imageBaseURL)\( viewModel.shelterDetail.photoURL ?? "")" )) { photoDownload in
                        photoDownload
                            .resizable()
                            .frame(width: 250, height: 250)
                            .aspectRatio(contentMode:.fit)
                            .cornerRadius(10)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .aspectRatio(contentMode:.fit)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.top,5)
            .onTapGesture {
                viewModel.displayAlert = false
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, isImageSelected: self.$isImageSelected)
            }
            
            VStack (alignment: .leading){
                Text("Dirección")
                
                TextField(text: $viewModel.searchableAddress){
                }
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                .onReceive(viewModel.$searchableAddress.debounce(
                    for: .seconds(1), scheduler: DispatchQueue.main)) {
                        if (!isFirstLoaded) {
                            viewModel.searchAddress($0)
                        }
                        isFirstLoaded = false
                    }
                    .onChange(of: viewModel.searchableAddress) { newValue in
                        if (!newValue.isEmpty && newValue != addressContent) {
                            addressSelected = false
                        }
                        
                    }
                    .modifier(ClearButton(text: $viewModel.searchableAddress))
            }
            .padding(.top,15)
            
            
            ZStack{
                VStack{
                    VStack (alignment: .leading){
                        Text("Teléfono")
                        
                        TextField(text: $viewModel.shelterDetail.phoneNumber) {
                            
                        }
                        .padding(8)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(Color.gray)
                        })
                        .modifier(ClearButton(text: $viewModel.shelterDetail.phoneNumber))
                        
                    }.padding(.top,5)
                    
                    VStack(alignment: .leading) {
                        Text("¿Qué soy?")
                        
                        Picker(selection: $viewModel.shelterDetail.shelterType, label: Text("Shelter Type")) {
                            
                            ForEach(shelterTypes, id: \.self) {
                                Text($0.description)
                                
                            }
                            
                        }
                        .frame(height: 90)
                        .pickerStyle(.inline)
                        .padding(0)
                    }
                    
                    Button {
                        Task{
                            await viewModel.updateShelter(image: image)
                        }
                    } label: {
                        Text("Guardar cambios")
                            .padding()
                            .foregroundColor(Color.white)
                            .font(Font.custom("Moderat-Bold", size: 18))
                            .frame(width: 200, height: 50)
                            .background(Color("RedKiwoko"))
                            .cornerRadius(5)
                    }
                    .padding(.top, 15)
                    .shadow(radius: 10.0, x:20, y:10)
                }
                if (!addressSelected && !viewModel.searchableAddress.isEmpty && !viewModel.addressResults.isEmpty) {
                    List{
                        ForEach(viewModel.addressResults) {
                            let text = "\($0.title), \($0.subtitle)"
                            Text("\($0.title), \($0.subtitle)")
                                .onTapGesture {
                                    addressSelected = true
                                    addressContent = text
                                    viewModel.searchableAddress = text
                                    
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                
            }
            
            switch viewModel.status {
                
            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .padding(.top,10)
                
            default:
                Spacer()
                
            }
            
            Spacer()
            
        }.padding([.leading, .trailing], 20)
            .onAppear{
                Task{
                    await viewModel.getShelterDetail(userId:userId)
                }
            }
            .alert(isPresented: $viewModel.displayAlert) {
                if case let .error(message) = viewModel.status {
                    return Alert(title: Text("Error"),
                                 message: Text(message))
                }
                
                if case .loaded = viewModel.status {
                    return Alert(title: Text("Registro completado"),
                                 message: Text("Datos guardados con éxito"))
                }
                
                return Alert(title: Text(""))
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(userId: "ac7128c3-3be9-436f-b545-319e0b5d77fa")
    }
}


