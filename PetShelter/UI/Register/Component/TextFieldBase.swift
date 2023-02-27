//
//  TextFieldBase.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 23/2/23.
//

import SwiftUI
import Combine

struct TextFieldBase: View {
    @EnvironmentObject var viewModel: RegisterViewModel
    @Binding var text: String
    var nameField: String
    var type: TextFieldType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(nameField)
                .font(.caption)
            
            switch type {
            case .textFieldBase:
                TextField(nameField, text: $text)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(viewModel.validateUserName(userName: text) ? Color.green : Color.gray)
                    })
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
            case .secureField:
                SecureField(nameField, text: $text)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(
                                viewModel.validateUserName(userName: text) && viewModel.validatePassword(password: text) ? Color.green : Color.gray)
                    })
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
            case .onlyNumbersField:
                TextField(nameField, text: $text)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(
                                viewModel.validateUserName(userName: text) &&
                                viewModel.validatePhoneNumber(phoneNumber: text) ? Color.green : Color.gray)
                    })
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .onReceive(Just(text)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.text = filtered
                        }
                    }
            }
        }
    }
}

struct TextFieldBase_Previews: PreviewProvider {
    
    static var previews: some View {
        TextFieldBase(text: .constant(""), nameField: "", type: .textFieldBase)
    }
}
