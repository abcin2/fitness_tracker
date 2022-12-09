import Combine
import SwiftUI

struct AttributeInputDoublePicker: View {
    
    class ViewModel: ObservableObject {
        @Published var pickerDisabled: Bool = true
        
        func togglePicker() {
            if pickerDisabled == true {
                pickerDisabled = false
            } else {
                pickerDisabled = true
            }
        }
    }
    
    @ObservedObject var viewModel = ViewModel()

    var attributeTitle: String
    
    @Binding var pickerSelection: Double
    var pickerSelections: [Double]
    
    var isDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(attributeTitle)
                Spacer()
                Button(String(pickerSelection)) {
                    viewModel.togglePicker()
                }
                .disabled(isDisabled)
            }
            if !viewModel.pickerDisabled {
                HStack {
                    Picker(attributeTitle, selection: $pickerSelection) {
                        ForEach(pickerSelections, id: \.self) { selection in
                            Text(String(format: "%.1f", selection))
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
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
