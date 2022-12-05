import SwiftUI
import Combine

extension RecordExerciseView {
    var ASCMachines: some View {
        VStack {
            Divider()
            HStack {
                Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)) {
                    TextField("Weight", text: $viewModel.weight)
                        .frame(width: 35)
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
                        .padding(.trailing)
                }
                .padding(.trailing)
            }
            Divider()
            switch workout {
            case ASCMachinesName.rowMachine.rawValue:
                HStack {
                    Section(header: Text("Chest Setting").frame(maxWidth: .infinity, alignment: .leading)) {
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
                HStack {
                    Section(header: Text("Seat Setting").frame(maxWidth: .infinity, alignment: .leading)) {
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
