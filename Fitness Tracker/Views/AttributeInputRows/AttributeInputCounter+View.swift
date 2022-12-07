import Combine
import SwiftUI

struct AttributeInputCounter: View {
    var attributeTitle: String
    
    @Binding var counterSelection: Int
    var incrementButton: ((_ value: Int) -> Int)
    var decrementButton: ((_ value: Int) -> Int)
    
    var isDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    Button(action: {
                        let newNum = decrementButton(counterSelection)
                        counterSelection = newNum
                        print(counterSelection)
                    }) {
                        Text("<")
                    }
                    .disabled(isDisabled)
                    Text("\(counterSelection)")
                    Button(action: {
                        let newNum = incrementButton(counterSelection)
                        counterSelection = newNum
                        print(counterSelection)
                    }) {
                        Text(">")
                    }
                    .disabled(isDisabled)
                }
                .frame(height: 50)
            }
            .padding(.horizontal)
            .overlay(Divider(), alignment: .top)
            .overlay(Divider(), alignment: .bottom)
        }
    }
}

struct AttributeInputCounter_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputCounter(
        attributeTitle: "Counter Attribute",
        counterSelection: .constant(1),
        incrementButton: { num in
            let value = num + 1
            return value
        },
        decrementButton: { num in
            let value = num - 1
            return value
        },
        isDisabled: false
        )
    }
}
