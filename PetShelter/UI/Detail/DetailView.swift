//
//  DetailView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 16/2/23.
//

import SwiftUI
import KeychainSwift
import RadioGroup


struct DetailView: View {
    
    @State var name = "Ayuntamiento Pozuelo"
    
    @State var address = ""
    
    @State var phone = ""
    
    @State var selectedType = 2
    
    @FocusState var isFocusOn: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center, spacing: 5){
                
                Spacer()

                TextField(text: $name) {
                    
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
            
            AsyncImage(url: URL(string: "")) { photoDownload in
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
            .padding(.top,5)
            
            VStack (alignment: .leading){
                Text("Dirección")
                
                TextField(text: $address) {
                    
                }
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                
            }.padding(.top,15)
            
            VStack (alignment: .leading){
                Text("Teléfono")
                
                TextField(text: $phone) {
                    
                }
                .padding(8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray)
                })
                
            }.padding(.top,5)
            
            VStack(alignment: .leading) {
                Text("¿Qué soy?")
                
                Picker(selection: $selectedType, label: Text("Favorite Color")) {
                    Text("Particular").tag(1)
                    Text("Ayuntamiento").tag(2)
                    Text("Veterinario").tag(3)
                    Text("Centro de acogida").tag(4)
                    Text("Tienda kiwoko").tag(5)
                }
                .frame(height: 90)
                .pickerStyle(.inline)
                .padding(0)
            }
            
            Button {
                //TODO: - Guardar cambios
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
            
            Spacer()
            
        }.padding([.leading, .trailing], 20)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
