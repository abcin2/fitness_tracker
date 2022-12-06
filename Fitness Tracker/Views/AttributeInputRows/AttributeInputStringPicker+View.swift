import Combine
import SwiftUI

struct AttributeInputStringPicker: View {
    var attributeTitle: String
    
    @Binding var pickerSelection: String
    var pickerSelections: [String]
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker(attributeTitle, selection: $pickerSelection) {
                        ForEach(pickerSelections, id: \.self) { selection in
                            Text(selection)
                        }
                    }
                }
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct AttributeInputStringPicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputStringPicker(
            attributeTitle: "Picker Attribute",
            pickerSelection: .constant("2"),
            pickerSelections: ["1", "2", "3"]
        )
    }
}
