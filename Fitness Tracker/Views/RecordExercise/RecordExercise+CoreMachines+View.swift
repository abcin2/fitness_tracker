import SwiftUI
import Combine

extension RecordExerciseView {
    var coreMachines: some View {
        VStack {
            Divider()
            switch workout {
            case coreMachinesName.crunchMachine.rawValue, coreMachinesName.torsoRotation.rawValue:
                HStack {
                    Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Weight", text: $viewModel.weight)
                            .frame(width: 35)
                            .fixedSize()
                            .keyboardType(.numberPad)
                            .disabled(viewModel.fieldsDisabled)
                            .onReceive(Just(viewModel.weight)) { newValue in
                                let numFiltered = newValue.filter { "0123456789".contains($0) }
                                let sizeFiltered = numFiltered.prefix(3)
                                if sizeFiltered != newValue {
                                    self.viewModel.weight = String(sizeFiltered)
                                }
                            }
                        Text("lbs")
                    }
                    .padding(.horizontal)
                    .padding(.trailing)
                }
                Divider()
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.createIntArr(from: 1, through: 10, by: 1), id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            default:
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.createIntArr(from: 1, through: 10, by: 1), id: \.self) { number in
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
            HStack {
                Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Sets", selection: $viewModel.sets) {
                        ForEach(viewModel.createIntArr(from: 1, through: 10, by: 1), id: \.self) { number in
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
                Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Reps", selection: $viewModel.reps) {
                        ForEach(viewModel.repOptions, id: \.self) { number in
                            Text(number)
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
    
    enum coreMachinesName: String {
        case crunchMachine = "Crunch Machine"
        case torsoRotation = "Torso Rotation"
        case mountainClimberMachine = "Mountain Climber Machine"
        case declineBench = "Decline Bench"
        case hangingLegRaiseStation = "Hanging Leg Raise Station"
    }
}
