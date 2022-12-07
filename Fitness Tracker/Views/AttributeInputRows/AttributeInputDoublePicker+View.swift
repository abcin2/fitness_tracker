import Combine
import SwiftUI

struct AttributeInputDoublePicker: View {
    var attributeTitle: String
    
    @Binding var pickerSelection: Double
    var pickerSelections: [Double]
    
    var isDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker(attributeTitle, selection: $pickerSelection) {
                        ForEach(pickerSelections, id: \.self) { selection in
                            Text(String(format: "%.1f", selection))
                        }
                    }
                    .disabled(isDisabled)
                    .frame(height: 50)
                }
            }
            .padding(.horizontal)
            .overlay(Divider(), alignment: .top)
            .overlay(Divider(), alignment: .bottom)
        }
    }
}

struct AttributeInputDoublePicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputDoublePicker(
            attributeTitle: "Picker Attribute",
            pickerSelection: .constant(2.0),
            pickerSelections: [1.0, 2.0, 3.0],
            isDisabled: false
        )
    }
}
