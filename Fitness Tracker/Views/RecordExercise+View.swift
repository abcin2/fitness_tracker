import SwiftUI
import Combine

struct RecordExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    @State var exercise: String
    var body: some View {
        VStack {
            switch viewModel.findCategory(for: exercise) {
            case "Cardio Machines":
                cardioMachines
            case "Arm, Shoulder & Chest Machines":
                ASCMachines
            case "Leg Machines":
                legMachines
            case "Core Machines":
                coreMachines
            case "Other":
                other
            default:
                unknown
            }
            Spacer()
            timer
                .padding()
            Spacer()
        }
        .navigationTitle(exercise)
        .padding(.top, 25)
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }
}

private extension RecordExerciseView {
    var unknown: some View {
        VStack {
            Text("Cannot find associated category. Please try again")
        }
    }
}

struct RecordExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        RecordExerciseView(exercise: "Freeweights")
    }
}
