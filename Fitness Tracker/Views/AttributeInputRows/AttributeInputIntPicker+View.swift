import Combine
import SwiftUI

struct AttributeInputIntPicker: View {
    var attributeTitle: String
    
    @Binding var pickerSelection: Int
    var pickerSelections: [Int]
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker(attributeTitle, selection: $pickerSelection) {
                        ForEach(pickerSelections, id: \.self) { selection in
                            Text("\(selection)")
                        }
                    }
                }
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct AttributeInputIntPicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputIntPicker(
            attributeTitle: "Picker Attribute",
            pickerSelection: .constant(2),
            pickerSelections: [1, 2, 3]
        )
    }
}
