import SwiftUI
import Combine

extension RecordExerciseView {
    var coreMachines: some View {
        VStack {
            List {
                switch workout {
                case coreMachinesName.crunchMachine.rawValue, coreMachinesName.torsoRotation.rawValue:
                    AttributeInputTextField(
                        attributeTitle: "Weight",
                        textSelection: $viewModel.weight,
                        trailingText: "lbs",
                        isDisabled: viewModel.fieldsDisabled
                    )
                    AttributeInputIntPicker(
                        attributeTitle: "Machine Setting",
                        pickerDisabled: $viewModel.settingOnePickerDisabled,
                        pickerSelection: $viewModel.machineSetting,
                        pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                        isDisabled: viewModel.fieldsDisabled
                    )
                default:
                    AttributeInputIntPicker(
                        attributeTitle: "Machine Setting",
                        pickerDisabled: $viewModel.settingOnePickerDisabled,
                        pickerSelection: $viewModel.machineSetting,
                        pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                        isDisabled: viewModel.fieldsDisabled
                    )
                }
                AttributeInputIntPicker(
                    attributeTitle: "Sets",
                    pickerDisabled: $viewModel.setsPickerDisabled,
                    pickerSelection: $viewModel.sets,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputStringPicker(
                    attributeTitle: "Reps",
                    pickerDisabled: $viewModel.repsPickerDisabled,
                    pickerSelection: $viewModel.reps,
                    pickerSelections: viewModel.repOptions,
                    isDisabled: viewModel.fieldsDisabled
                )
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
