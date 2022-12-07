import Combine
import Foundation
import SwiftUI

struct ExerciseCategoryHeader<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text("Details:")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            self.content
        }
        .padding(.vertical)
    }
}
