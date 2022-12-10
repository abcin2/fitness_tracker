import Combine
import SwiftUI

struct AttributeInputStringPicker: View {
    
    var attributeTitle: String
    
    @Binding var pickerDisabled: Bool
    @Binding var pickerSelection: String
    var pickerSelections: [String]
    
    var isDisabled: Bool
    
    func togglePicker() {
        if pickerDisabled == false {
            pickerDisabled = true
        } else if pickerDisabled == true {
            pickerDisabled = false
        }
    }
    
    var body: some View {
        HStack {
            Text(attributeTitle)
            Spacer()
            Button(String(pickerSelection)) {
               togglePicker()
            }
            .disabled(isDisabled)
        }
        if !pickerDisabled {
            Picker(attributeTitle, selection: $pickerSelection) {
                ForEach(pickerSelections, id: \.self) { selection in
                    Text(selection)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct AttributeInputStringPicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputStringPicker(
            attributeTitle: "Picker Attribute",
            pickerDisabled: .constant(false),
            pickerSelection: .constant("2"),
            pickerSelections: ["1", "2", "3"],
            isDisabled: false
        )
    }
}
