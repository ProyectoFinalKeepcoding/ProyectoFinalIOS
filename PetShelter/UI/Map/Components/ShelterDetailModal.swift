//
//  ShelterDetailModal.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 9/2/23.
//

import SwiftUI
import CoreLocation
import MapKit

/// Vista que representa el modal con el detalle del punto del mapa
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
            .background(Color("GrayKiwoko"))
            .padding(.bottom,20)
            
            HStack(alignment: .center, spacing: 30){
                
                AsyncImage(url: URL(string: "\(imageBaseURL)\( shelter.photoURL ?? "")")) { photoDownload in
                    
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
                        callNumber(phoneNumber: shelter.phoneNumber)
                    } label: {
                        HStack{
                            Spacer()
                            Text(shelter.phoneNumber)
                                .font(Font.custom("Moderat-Bold", size: 20))
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "Phone")!)
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30)
                            
                        }
                    }.tint(Color.white)
                        .padding(15)
                        .background(Color("RedKiwoko"))
                        .cornerRadius(10)
                    
                    Button {
                        //TODO: - Ir al sitio
                        showRoute(address: shelter.address)

                    } label: {
                        
                        HStack{
                            Spacer()
                            Text("Ir")
                                .font(Font.custom("Moderat-Bold", size: 20))
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "Directions")!)
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                        }
                    }.tint(Color.white)
                        .padding(15)
                        .background(Color("RedKiwoko"))
                        .cornerRadius(10)
                }
                
            }
            
            Spacer()
        }
        
        .padding()
    }
}

private func callNumber(phoneNumber: String) {
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application: UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}

private func showRoute(address: Address) {
    let coordinate = CLLocationCoordinate2DMake(address.latitude,address.longitude)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
    mapItem.name = "Destination"
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
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
