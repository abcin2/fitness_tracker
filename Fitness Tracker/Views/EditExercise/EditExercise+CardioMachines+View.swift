import Combine
import SwiftUI

extension EditExerciseView {
    var cardioMachines: some View {
        VStack {
            List {
                timer
                ExerciseCategoryHeader {
                    switch workout.name {
                    case cardioMachinesName.treadmill.rawValue:
                        AttributeInputDoublePicker(
                            attributeTitle: "Intensity Level",
                            pickerDisabled: $viewModel.intensityPickerDisabled,
                            pickerSelection: $viewModel.intensityLevel,
                            pickerSelections: viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1),
                            isDisabled: false
                        )
                        AttributeInputDoublePicker(
                            attributeTitle: "Incline Level",
                            pickerDisabled: $viewModel.settingOnePickerDisabled,
                            pickerSelection: $viewModel.inclineLevel,
                            pickerSelections: viewModel.createDoubleArr(from: 0.0, through: 20.0, by: 0.5),
                            isDisabled: false
                        )
                    case cardioMachinesName.recumbentBike.rawValue, cardioMachinesName.stationaryBike.rawValue:
                        AttributeInputIntPicker(
                            attributeTitle: "Intensity Level",
                            pickerDisabled: $viewModel.intensityPickerDisabled,
                            pickerSelection: $viewModel.bikeIntensityLevel,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 50, by: 1),
                            isDisabled: false
                        )
                        AttributeInputIntPicker(
                            attributeTitle: "Seat Height",
                            pickerDisabled: $viewModel.settingOnePickerDisabled,
                            pickerSelection: $viewModel.machineSetting,
                            pickerSelections: viewModel.createIntArr(from: 1, through: 25, by: 1),
                            isDisabled: false
                        )
                    default:
                        AttributeInputDoublePicker(
                            attributeTitle: "Intensity Level",
                            pickerDisabled: $viewModel.intensityPickerDisabled,
                            pickerSelection: $viewModel.intensityLevel,
                            pickerSelections: viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1),
                            isDisabled: false
                        )
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
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
