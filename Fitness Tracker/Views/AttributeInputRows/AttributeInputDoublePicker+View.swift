import Combine
import SwiftUI

struct AttributeInputDoublePicker: View {
    var attributeTitle: String
    
    @Binding var pickerSelection: Double
    var pickerSelections: [Double]
    
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

struct AttributeInputDoublePicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputDoublePicker(
            attributeTitle: "Picker Attribute",
            pickerSelection: .constant(2.0),
            pickerSelections: [1.0, 2.0, 3.0]
        )
    }
}
