//
//  LocationDetailView.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 7/2/23.
//

import SwiftUI

struct LocationDetailView: View {
    
    @State var name: String
    
    var body: some View {
        
        VStack{
            VStack(alignment: .leading) {
                
                Text(name)
                    .font(.title)
                
                HStack{
                    Text("Shelter adress")
                    Spacer()
                    Text("City")
                }
                
                Divider()
                
                Text("Description")
                    .font(.title2)
                Text("Descriptive text goes here.")
            }
            .padding(.bottom,20)
            
            
            Image("shelter_demo")
                .resizable()
                .frame(height: 200)
                
            
            HStack{
                Spacer()
                Image(systemName: "phone.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
                
                Text("912345678")
                    .fontWeight(.bold)
            }
            .padding(.top,10)
            
            
            Spacer()
        }

        .padding()

    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(name: "Shelter name")
    }
}
