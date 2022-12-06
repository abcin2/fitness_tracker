import SwiftUI
import Combine

extension RecordExerciseView {
    var cardioMachines: some View {
        VStack {
            Divider()
            switch workout {
            case cardioMachinesName.treadmill.rawValue:
                AttributeInputDoublePicker(
                    attributeTitle: "Intensity Level",
                    pickerSelection: $viewModel.intensityLevel,
                    pickerSelections: viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputDoublePicker(
                    attributeTitle: "Incline Level",
                    pickerSelection: $viewModel.inclineLevel,
                    pickerSelections: viewModel.createDoubleArr(from: 0.0, through: 20.0, by: 0.5),
                    isDisabled: viewModel.fieldsDisabled
                )
            case cardioMachinesName.recumbentBike.rawValue, cardioMachinesName.stationaryBike.rawValue:
                AttributeInputIntPicker(
                    attributeTitle: "Intensity Level",
                    pickerSelection: $viewModel.bikeIntensityLevel,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 50, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputIntPicker(
                    attributeTitle: "Seat Height",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 25, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
            default:
                AttributeInputDoublePicker(
                    attributeTitle: "Intensity Level",
                    pickerSelection: $viewModel.intensityLevel,
                    pickerSelections: viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1),
                    isDisabled: viewModel.fieldsDisabled
                )
            }
        }
    }
    
    enum cardioMachinesName: String {
        case treadmill = "Treadmill"
        case elliptical = "Elliptical"
        case stairclimber = "Stairclimber"
        case stationaryBike = "Stationary Bike"
        case recumbentBike = "Recumbent Bike"
        case arcTrainer = "ARC Trainer"
    }
}
