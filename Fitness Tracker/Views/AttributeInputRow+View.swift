import Combine
import SwiftUI

struct AttributeInputRowView: View {
    var attributeTitle: String
    var inputType: inputs
    // for Picker
    @Binding var pickerSelection: String
    var pickerSelections: [String]
    // for TextField
    @Binding var textSelection: String
    var receivingFunction: ((_ value: String) -> String)
    var trailingText: String?
    
    enum inputs {
        case picker
        case textfield
    }
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    switch inputType {
                    case .picker:
                        Picker(attributeTitle, selection: $pickerSelection) {
                            ForEach(pickerSelections, id: \.self) { selection in
                                Text(selection)
                            }
                        }
                    case .textfield:
                        TextField(attributeTitle, text: $textSelection)
                            .keyboardType(.numberPad)
                            .onReceive(Just(textSelection)) { newValue in
                                let newString = receivingFunction(newValue)
                                textSelection = newString
                                }
                            }
                        Text(trailingText ?? "")
                    }
                }
                .padding(.horizontal)
            }
            Divider()
    }
        // each row will always end with a Divider() because the edit and record views begin with a divider
}

struct AttributeInputRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Divider()
            AttributeInputRowView(
                attributeTitle: "Reps",
                inputType: .picker,
                pickerSelection: .constant("2"),
                pickerSelections: ["1", "2", "3"],
                textSelection: .constant("Text")
            ) {value in
                return value
            }
        }
    }
}
