import Combine
import SwiftUI

struct AttributeInputCounterView: View {
    var attributeTitle: String
    
    @Binding var counterSelection: Int
    var incrementButton: ((_ value: Int) -> Int)
    var decrementButton: ((_ value: Int) -> Int)
    
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
            .padding(.horizontal)
            Divider()
        }
    }
}

struct AttributeInputCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputCounterView(
        attributeTitle: "Counter Attribute",
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
