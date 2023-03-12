//
//  PopUpRegister.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/3/23.
//

import SwiftUI

struct PopUpRegister: View {
    @State var type: PopUpType
    @Binding var isHidden: Bool
    
    init(type: PopUpType = .failure, isHidden: Binding<Bool> = .constant(false) ) {
        self.type = type
        _isHidden = isHidden
    }
    
    var body: some View {
        if !isHidden {
            ZStack {
                VStack(spacing: 32) {
                    Image(systemName: type == .success ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                        .foregroundColor(type == .success ? .green : .red)
                        .font(.system(size: 80))
                    Text(type == .success ? "El registro se completó con exito." : "Lo sentimos, ha ocurrido un error.")
                    NavigationLink(destination: {
                        LoginView()
                    }, label: {
                        Text("Aceptar")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 48)
                            .background(Color("RedKiwoko"))
                            .cornerRadius(4)
                            .shadow(radius: 6)

                    })
                }
            }
            .frame(width: 250, height: 250)
            .padding(32)
            .background(.gray.opacity(0.7))
            .cornerRadius(16)
        }
    }
}

struct PopUpRegister_Previews: PreviewProvider {
    static var previews: some View {
        PopUpRegister()
    }
}
