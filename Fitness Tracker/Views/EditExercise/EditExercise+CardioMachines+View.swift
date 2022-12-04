import Combine
import SwiftUI

extension EditExerciseView {
    var cardioMachines: some View {
        VStack {
            Divider()
            if workout.name == "Treadmill" {
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
            }
            if workout.name!.contains("Bike") {
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.intensityLevel) {
                            ForEach(viewModel.bikeIntensityLevels, id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
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
            }
        }
    }
}
