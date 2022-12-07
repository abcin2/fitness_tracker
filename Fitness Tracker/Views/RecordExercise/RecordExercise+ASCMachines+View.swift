import SwiftUI
import Combine

extension RecordExerciseView {
    var ASCMachines: some View {
        VStack {
            AttributeInputTextField(
                attributeTitle: "Weight",
                textSelection: $viewModel.weight,
                trailingText: "lbs",
                isDisabled: viewModel.fieldsDisabled
            )
            switch workout {
            case ASCMachinesName.rowMachine.rawValue:
                AttributeInputIntPicker(
                    attributeTitle: "Chest Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputIntPicker(
                    attributeTitle: "Seat Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
            default:
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
            }
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
        }
        .overlay(Divider(), alignment: .top)
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
