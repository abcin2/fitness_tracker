import SwiftUI
import Combine

extension RecordExerciseView {
    var other: some View {
        VStack {
            Divider()
            switch workout {
            case othersName.freeweights.rawValue:
                AttributeInputTextField(
                    attributeTitle: "Exercise/Muscles",
                    textSelection: $viewModel.freeWeightExercise,
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputTextField(
                    attributeTitle: "Weight",
                    textSelection: $viewModel.weight,
                    trailingText: "lbs",
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputIntPicker(
                    attributeTitle: "Sets",
                    pickerSelection: $viewModel.sets,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputStringPicker(
                    attributeTitle: "Reps",
                    pickerSelection: $viewModel.reps,
                    pickerSelections: viewModel.repOptions,
                    isDisabled: viewModel.fieldsDisabled
                )
            default:
                EmptyView()
            }
        }
    }
    
    enum othersName: String {
        case freeweights = "Freeweights"
        case walking = "Walking"
        case running = "Running"
        case hiking = "Hiking"
        case biking = "Biking"
        case yoga = "Yoga"
        case stretching = "Stretching"
    }
}
