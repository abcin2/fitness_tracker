import Combine
import SwiftUI

extension EditExerciseView {
    var cardioMachines: some View {
        VStack {
            Divider()
            switch workout.name {
            case cardioMachinesName.treadmill.rawValue:
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.intensityLevel) {
                            ForEach(viewModel.intensityLevels, id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
                HStack {
                    Section(header: Text("Incline Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Incline Level", selection: $viewModel.inclineLevel) {
                            ForEach(viewModel.treadmillInclineLevels, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            case cardioMachinesName.recumbentBike.rawValue, cardioMachinesName.stationaryBike.rawValue:
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.bikeIntensityLevel) {
                            ForEach(viewModel.bikeIntensityLevels, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
                HStack {
                    Section(header: Text("Seat Height").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Seat Height", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.bikeSeatHeight, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            default:
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.intensityLevel) {
                            ForEach(viewModel.intensityLevels, id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
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
