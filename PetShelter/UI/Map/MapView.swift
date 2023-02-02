//
//  MapView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack {
            Header()
            ZStack {
                Map()
                    .ignoresSafeArea()
                AidButton()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
