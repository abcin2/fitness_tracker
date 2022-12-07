import Combine
import SwiftUI

extension EditExerciseView {
    var other: some View {
        VStack {
            switch workout.name {
            case othersName.freeweights.rawValue:
                AttributeInputTextField(
                    attributeTitle: "Exercise/Muscles",
                    textSelection: $viewModel.freeWeightExercise,
                    isDisabled: false
                )
                AttributeInputTextField(
                    attributeTitle: "Weight",
                    textSelection: $viewModel.weight,
                    trailingText: "lbs",
                    isDisabled: false
                )
                AttributeInputIntPicker(
                    attributeTitle: "Sets",
                    pickerSelection: $viewModel.sets,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: false
                )
                AttributeInputStringPicker(
                    attributeTitle: "Reps",
                    pickerSelection: $viewModel.reps,
                    pickerSelections: viewModel.repOptions,
                    isDisabled: false
                )
            default:
                EmptyView()
            }
        }
        .overlay(Divider(), alignment: .top)
    }
    
    enum othersName: String {
        case freeweights = "Freeweights"
        case walking = "Walking"
        case running = "Running"
        case hiking = "Hiking"
        case yoga = "Yoga"
        case stretching = "Stretching"
    }
}
