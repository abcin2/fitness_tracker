import Combine
import Foundation
import SwiftUI

struct ExerciseCategoryHeader<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Section(header: Text("Details:")) {
            self.content
        }
    }
}
