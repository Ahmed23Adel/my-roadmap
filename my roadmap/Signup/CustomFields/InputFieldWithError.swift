//
//  InputFieldWithError.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct InputFieldWithErrorView<Content: View>: View {
    @ObservedObject var field: InputFieldValueAndErrorData
    var content: Content

    init(field: InputFieldValueAndErrorData, @ViewBuilder content: () -> Content) {
        self.field = field
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            content
            if field.showError {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text(field.errorMsg)
                        .foregroundColor(.red)
                        .font(.caption)
                    Spacer()
                }
            }
        }
    }
}


struct InputFieldWithError_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldWithErrorView(field: InputFieldValueAndErrorData()) {
            TextField("Email", text: .constant("test@example.com"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
    }
}

