//
//  ShelterDetailModal.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 9/2/23.
//

import SwiftUI

struct ShelterDetailModal: View {
    
    @State var shelter: ShelterPointModel
    
    var body: some View {
        
        VStack{
            VStack(alignment: .center) {
                Divider()
                    .frame(minHeight: 2)
                    .overlay(Color.black)
                
                Text(shelter.name)
                    .font(.title)
                    .frame(width: .infinity ,alignment: .center)
                    .foregroundColor(Color.black)
                
                Divider()
                    .frame(minHeight: 2)
                    .overlay(Color.black)
                
            }
            .background(Color("Gray Kiwoko"))
            .padding(.bottom,20)
            
            HStack(alignment: .center, spacing: 30){
                
                AsyncImage(url: URL(string: "\(server)/\( shelter.photoURL ?? "").png")) { photoDownload in
                    
                    photoDownload
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: 150 ,height: 150)
                        .cornerRadius(10)
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: 150 ,height: 150)
                        .cornerRadius(10)
                    
                }
                
                VStack(alignment: .center, spacing: 20){
                    
                    Button {
                        //TODO: - Llamar
                    } label: {
                        HStack{
                            Spacer()
                            Text(shelter.phoneNumber)
                                .fontWeight(.bold)
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "Phone")!)
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30)
                            
                        }
                    }.tint(Color.white)
                        .padding(15)
                        .background(Color("Red Kiwoko"))
                        .cornerRadius(10)
                    
                    Button {
                        //TODO: - Ir al sitio
                    } label: {
                        
                        HStack{
                            Spacer()
                            Text("Ir")
                                .fontWeight(.bold)
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "Directions")!)
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                        }
                    }.tint(Color.white)
                        .padding(15)
                        .background(Color("Red Kiwoko"))
                        .cornerRadius(10)
                }
                
            }
            
            Spacer()
        }
        
        .padding()
    }
}

struct ShelterDetailModal_Previews: PreviewProvider {
    static var previews: some View {
        ShelterDetailModal(
            shelter: ShelterPointModel(
                id: "Id",
                name: "Fran",
                phoneNumber: "612345678",
                address: Address(
                    latitude: -4.030329,
                    longitude: 39.865762),
                shelterType: .particular,
                photoURL: "https://media.gettyimages.com/id/565299235/es/foto/female-volunteers-petting-a-dog-in-animal-shelter.jpg?s=612x612&w=gi&k=20&c=1Wx3mygY5YWukh_fVdYOTYsK_vslyskIZ9P5lyJeWAI=")
        )
    }
}
