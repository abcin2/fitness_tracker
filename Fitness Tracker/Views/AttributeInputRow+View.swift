import SwiftUI

struct AttributeInputRow_View: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        // this will be the component used for each row
        // Need to include:
            // HStack
            // Section
            // Picker or TextField
        Divider()
        // each row will always end with a Divider() because the edit and record views begin with a divider
    }
}

struct AttributeInputRow_View_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputRow_View()
    }
}
