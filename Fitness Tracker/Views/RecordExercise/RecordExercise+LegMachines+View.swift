import SwiftUI
import Combine

extension RecordExerciseView {
    var legMachines: some View {
        VStack {
            List {
                AttributeInputTextField(
                    attributeTitle: "Weight",
                    textSelection: $viewModel.weight,
                    trailingText: "lbs",
                    isDisabled: viewModel.fieldsDisabled
                )
                switch workout {
                case legMachinesName.seatedLegPress.rawValue:
                    AttributeInputIntPicker(
                        attributeTitle: "Machine Setting",
                        pickerDisabled: $viewModel.settingOnePickerDisabled,
                        pickerSelection: $viewModel.machineSetting,
                        pickerSelections: viewModel.createIntArr(from: 1, through: 15, by: 1),
                        isDisabled: viewModel.fieldsDisabled
                    )
                case legMachinesName.calfExtension.rawValue:
                    AttributeInputIntPicker(
                        attributeTitle: "Machine Setting",
                        pickerDisabled: $viewModel.settingOnePickerDisabled,
                        pickerSelection: $viewModel.machineSetting,
                        pickerSelections: viewModel.createIntArr(from: 1, through: 5, by: 1),
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
    
    enum legMachinesName: String {
        case seatedLegPress = "Seated Leg Press"
        case angledLegCurlMachine = "Angled Leg Curl Machine"
        case legExtensionMachine = "Leg Extension Machine"
        case sledPush = "Sled Push"
        case calfExtension = "Calf Extension"
    }
}
