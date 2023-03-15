//
//  UserTypePicker.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 23/2/23.
//

import SwiftUI

struct UserTypePicker: View {
    @Binding var selectedOption: ShelterType
    
    var body: some View {
        Picker("Tipo", selection: $selectedOption) {
            Text("Particular").tag(ShelterType.particular)
            Text("Ayuntamiento").tag(ShelterType.localGovernment)
            Text("Veterinario").tag(ShelterType.veterinary)
            Text("Refugio").tag(ShelterType.shelterPoint)
            Text("Tienda Kiwoko").tag(ShelterType.kiwokoStore)
        }
        .pickerStyle(.wheel)
    }
}

