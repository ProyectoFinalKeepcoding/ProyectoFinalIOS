//
//  PetShelterApp.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import GoogleMaps

@main
struct PetShelterApp: App {
    init()  {
        GMSServices.provideAPIKey("AIzaSyBzYlfOZo0Z7oyMWbrajwSXVuNU_ePDwkk")
    }
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
