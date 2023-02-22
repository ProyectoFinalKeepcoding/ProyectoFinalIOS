//
//  DetailView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 16/2/23.
//

import SwiftUI
import KeychainSwift
import RadioGroup

//            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrBCP-OgVDqreIVehp9Fvw7guCg9LgPEX3mQ&usqp=CAU

struct DetailView: View {
    
    @State var address = ""
    
    @State var phone = ""
    
    @State var selectedType = 1
    
    var body: some View {
        VStack {
            Text("Ayuntamiento Pozuelo")
                .font(Font.custom("Moderat-Bold",size: 22))
                .padding(.top, 50)
            
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
                .pickerStyle(.segmented)
                .colorMultiply(.blue)
                
            }
            .padding(.top, 5)
            
            Button {
                //TODO: - Guardar cambios
            } label: {
                Text("Guardar cambios")
                    .padding()
                    .foregroundColor(Color.white)
                    .font(Font.custom("Moderat-Medium", size: 18))
                    .frame(width: 200, height: 50)
                    .background(Color("RedKiwoko"))
                    .cornerRadius(5)
            }
            .padding(.top, 15)

            
            Spacer()
            
        }.padding([.leading, .trailing], 20)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
