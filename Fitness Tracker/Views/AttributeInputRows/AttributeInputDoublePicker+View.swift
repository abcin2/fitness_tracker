import Combine
import SwiftUI

struct AttributeInputDoublePicker: View {

    var attributeTitle: String
    
    @Binding var pickerDisabled: Bool
    @Binding var pickerSelection: Double
    var pickerSelections: [Double]
    
    var isDisabled: Bool
    
    var body: some View {
        HStack {
            Text(attributeTitle)
            Spacer()
            Button(String(pickerSelection)) {
                if pickerDisabled == false {
                    pickerDisabled = true
                } else if pickerDisabled == true {
                    pickerDisabled = false
                }
            }
            .disabled(isDisabled)
        }
        if !pickerDisabled {
            Picker(attributeTitle, selection: $pickerSelection) {
                ForEach(pickerSelections, id: \.self) { selection in
                    Text(String(format: "%.1f", selection))
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct AttributeInputDoublePicker_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputDoublePicker(
            attributeTitle: "Picker Attribute",
            pickerDisabled: .constant(false),
            pickerSelection: .constant(2.0),
            pickerSelections: [1.0, 2.0, 3.0],
            isDisabled: false
        )
    }
}
