//
//  LoadingView.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 6/3/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(3)
            .tint(Color("RedKiwoko"))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
