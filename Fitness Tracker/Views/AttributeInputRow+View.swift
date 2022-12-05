import Combine
import SwiftUI

struct AttributeInputRowView: View {
    var inputType: inputs
    var attributeTitle: String
    // for Picker
    @Binding var pickerSelection: String
    var pickerSelections: [String]
    // for TextField
    @Binding var textSelection: String
    var receivingFunction: ((_ value: String) -> String)
    var trailingText: String?
    // for counter
    @Binding var counterSelection: Int
    var incrementButton: ((_ value: Int) -> Int)
    var decrementButton: ((_ value: Int) -> Int)

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
                        Text(trailingText ?? "")
                    case .counter:
                        Button(action: {
                            let newNum = decrementButton(counterSelection)
                            counterSelection = newNum
                            print(counterSelection)
                        }) {
                            Text("<")
                        }
                        Text("\(counterSelection)")
                        Button(action: {
                            let newNum = incrementButton(counterSelection)
                            counterSelection = newNum
                            print(counterSelection)
                        }) {
                            Text(">")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        Divider()
    }
        // each row will always end with a Divider() because the edit and record views begin with a divider
}

extension AttributeInputRowView {
    enum inputs {
        case picker
        case textfield
        case counter
    }
}

struct AttributeInputRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Divider()
            AttributeInputRowView(
                inputType: .counter,
                attributeTitle: "Reps",
                pickerSelection: .constant("2"),
                pickerSelections: ["1", "2", "3"],
                textSelection: .constant("Text"),
                receivingFunction: { value in
                    return value
                },
                counterSelection: .constant(1),
                incrementButton: { num in
                    let value = num + 1
                    return value
                },
                decrementButton: { num in
                    let value = num - 1
                    return value
                }
            )
        }
    }
}
