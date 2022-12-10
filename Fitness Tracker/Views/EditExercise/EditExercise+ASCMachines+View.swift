import Combine
import SwiftUI

extension EditExerciseView {
    var ASCMachines: some View {
        VStack {
            List {
                timer
                ExerciseCategoryHeader {
                    AttributeInputTextField(
                        attributeTitle: "Weight",
                        textSelection: $viewModel.weight,
                        trailingText: "lbs",
                        isDisabled: false
                    )
                    switch workout.name {
                    case ASCMachinesName.rowMachine.rawValue:
                        AttributeInputIntPicker(
                            attributeTitle: "Chest Setting",
                            pickerDisabled: $viewModel.settingOnePickerDisabled,
                            pickerSelection: $viewModel.machineSetting,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                            isDisabled: false
                        )
                        AttributeInputIntPicker(
                            attributeTitle: "Seat Setting",
                            pickerDisabled: $viewModel.settingTwoPickerDisabled,
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
    
    enum ASCMachinesName: String {
        case bicepCurlStation = "Bicep Curl Station"
        case shoulderPress = "Shoulder Press"
        case bicepAndTricepCableCar = "Bicep and Tricep Cable Car"
        case chestPress = "Chest Press"
        case lateralPullDownMachine = "Lateral Pull-down Machine"
        case butterflyMachine = "Butterfly Machine"
        case inclinePress = "Incline Press"
        case rowMachine = "Row Machine"
        case tricepsPress = "Triceps Press"
    }
}
