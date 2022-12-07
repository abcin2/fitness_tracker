import Combine
import SwiftUI

extension EditExerciseView {
    var legMachines: some View {
        VStack {
            AttributeInputTextField(
                attributeTitle: "Weight",
                textSelection: $viewModel.weight,
                trailingText: "lbs",
                isDisabled: false
            )
            switch workout.name {
            case legMachinesName.seatedLegPress.rawValue:
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 15, by: 1),
                    isDisabled: false
                )
            case legMachinesName.calfExtension.rawValue:
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 5, by: 1),
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
        .overlay(Divider(), alignment: .top)
    }
    
    enum legMachinesName: String {
        case seatedLegPress = "Seated Leg Press"
        case angledLegCurlMachine = "Angled Leg Curl Machine"
        case legExtensionMachine = "Leg Extension Machine"
        case sledPush = "Sled Push"
        case calfExtension = "Calf Extension"
    }
}
