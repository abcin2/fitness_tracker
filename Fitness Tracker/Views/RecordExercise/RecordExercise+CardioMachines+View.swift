import SwiftUI
import Combine

extension RecordExerciseView {
    var cardioMachines: some View {
        VStack {
            Divider()
            if exercise == "Treadmill" {
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.intensityLevel) {
                            ForEach(viewModel.intensityLevels, id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
                HStack {
                    Section(header: Text("Incline Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Incline Level", selection: $viewModel.inclineLevel) {
                            ForEach(viewModel.treadmillInclineLevels, id: \.self) { number in
                                Text("\(number, specifier: "%.1f")")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            }
            if exercise.contains("Bike") {
                HStack {
                    Section(header: Text("Intensity Level").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Intensity Level", selection: $viewModel.intensityLevel) {
                            ForEach(viewModel.bikeIntensityLevels, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
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
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            }
        }
    }
}
