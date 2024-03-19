//
//  ButtonView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 31.10.23.
//

import SwiftUI

enum ButtonType {
    case primary
    case cancel
}

struct ButtonView: View {
    var text: String
    var buttonType: ButtonType
    
    init(text: String, buttonType: ButtonType = .primary) {
        self.text = text
        self.buttonType = buttonType
    }
    
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(buttonType == .primary ? Color.accentColor : Color("cancel"))
            .cornerRadius(12)
            .padding(.top, 8)
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Agendar consulta")
    }
}
