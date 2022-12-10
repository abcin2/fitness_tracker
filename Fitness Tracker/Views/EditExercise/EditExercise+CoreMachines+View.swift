import Combine
import SwiftUI

extension EditExerciseView {
    var coreMachines: some View {
        VStack {
            List {
                timer
                ExerciseCategoryHeader {
                    switch workout.name {
                    case coreMachinesName.crunchMachine.rawValue, coreMachinesName.torsoRotation.rawValue:
                        AttributeInputTextField(
                            attributeTitle: "Weight",
                            textSelection: $viewModel.weight,
                            trailingText: "lbs",
                            isDisabled: false
                        )
                        AttributeInputIntPicker(
                            attributeTitle: "Machine Setting",
                            pickerDisabled: $viewModel.settingOnePickerDisabled,
                            pickerSelection: $viewModel.machineSetting,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                            isDisabled: false
                        )
                    default:
                        AttributeInputIntPicker(
                            attributeTitle: "Machine Setting",
                            pickerDisabled: $viewModel.settingOnePickerDisabled,
                            pickerSelection: $viewModel.machineSetting,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                            isDisabled: false
                        )
                    }
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
                }
            }
            .buttonStyle(BorderlessButtonStyle())
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
