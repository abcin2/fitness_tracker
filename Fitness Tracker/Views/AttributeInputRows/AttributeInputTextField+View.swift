import Combine
import SwiftUI

struct AttributeInputTextFieldView: View {
    var attributeTitle: String
    
    @Binding var textSelection: String
    var receivingFunction: ((_ value: String) -> String)
    var trailingText: String?
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField(attributeTitle, text: $textSelection)
                        .keyboardType(.numberPad)
                        .onReceive(Just(textSelection)) { newValue in
                            let newString = receivingFunction(newValue)
                            textSelection = newString
                        }
                    Text(trailingText ?? "")
                }
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct AttributeInputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputTextFieldView(
            attributeTitle: "Text Field Attribute",
            textSelection: .constant("Text"),
            receivingFunction: { value in
                return value
            },
            trailingText: "lbs"
        )
    }
}
