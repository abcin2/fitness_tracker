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
