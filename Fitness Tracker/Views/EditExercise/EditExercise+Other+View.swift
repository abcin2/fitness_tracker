import Combine
import SwiftUI

extension EditExerciseView {
    var other: some View {
        VStack {
            List {
                timer
                ExerciseCategoryHeader {
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
                            pickerDisabled: $viewModel.setsPickerDisabled,
                            pickerSelection: $viewModel.sets,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                            isDisabled: false
                        )
                        AttributeInputStringPicker(
                            attributeTitle: "Reps",
                            pickerDisabled: $viewModel.repsPickerDisabled,
                            pickerSelection: $viewModel.reps,
                            pickerSelections: viewModel.repOptions,
                            isDisabled: false
                        )
                    default:
                        EmptyView()
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
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
