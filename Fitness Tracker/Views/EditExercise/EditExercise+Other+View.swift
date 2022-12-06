import Combine
import SwiftUI

extension EditExerciseView {
    var other: some View {
        VStack {
            Divider()
            switch workout.name {
            case othersName.freeweights.rawValue:
                AttributeInputTextField(
                    attributeTitle: "Exercise/Muscles",
                    textSelection: $viewModel.freeWeightExercise,
                    receivingFunction: { newValue in
                        return newValue
                    },
                    isDisabled: false
                )
                AttributeInputTextField(
                    attributeTitle: "Weight",
                    textSelection: $viewModel.weight,
                    receivingFunction: { newValue in
                        var returnString = ""
                        let numFiltered = newValue.filter { "0123456789".contains($0) }
                        let sizeFiltered = numFiltered.prefix(3)
                        if sizeFiltered != newValue {
                            returnString = String(sizeFiltered)
                        }
                        return returnString
                    },
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
