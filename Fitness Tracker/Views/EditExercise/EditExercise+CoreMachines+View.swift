import Combine
import SwiftUI

extension EditExerciseView {
    var coreMachines: some View {
        VStack {
            Divider()
            switch workout.name {
            case coreMachinesName.crunchMachine.rawValue, coreMachinesName.torsoRotation.rawValue:
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
                    isDisabled: false
                )
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: false
                )
            default:
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: false
                )
            }
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
        }
    }
    
    enum coreMachinesName: String {
        case crunchMachine = "Crunch Machine"
        case torsoRotation = "Torso Rotation"
        case mountainClimberMachine = "Mountain Climber Machine"
        case declineBench = "Decline Bench"
        case hangingLegRaiseStation = "Hanging Leg Raise Station"
    }
}
