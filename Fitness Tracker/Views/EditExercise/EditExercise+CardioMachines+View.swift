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
                            ForEach(viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1), id: \.self) { number in
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
                            ForEach(viewModel.createDoubleArr(from: 0.0, through: 20.0, by: 0.5), id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
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
                            ForEach(viewModel.createIntArr(from: 1, through: 50, by: 1), id: \.self) { number in
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
                            ForEach(viewModel.createIntArr(from: 1, through: 25, by: 1), id: \.self) { number in
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
                            ForEach(viewModel.createDoubleArr(from: 1.0, through: 20.0, by: 0.1), id: \.self) { number in
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
