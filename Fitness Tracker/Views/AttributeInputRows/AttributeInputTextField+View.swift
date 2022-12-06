import Combine
import SwiftUI

struct AttributeInputTextField: View {
    var attributeTitle: String
    
    @Binding var textSelection: String
    var receivingFunction: ((_ value: String) -> String)
    var trailingText: String?
    
    var isDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField(attributeTitle, text: $textSelection)
                        .disabled(isDisabled)
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

struct AttributeInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputTextField(
            attributeTitle: "Text Field Attribute",
            textSelection: .constant("Text"),
            receivingFunction: { value in
                return value
            },
            trailingText: "lbs",
            isDisabled: false
        )
    }
}
