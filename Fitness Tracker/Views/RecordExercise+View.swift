import SwiftUI
import Combine

struct RecordExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    @State var exercise: String
    var body: some View {
        VStack {
            switch viewModel.findCategory(for: exercise) {
            case "Cardio Machines":
                cardioMachines
            case "Arm, Shoulder & Chest Machines":
                ASCMachines
            case "Leg Machines":
                legMachines
            case "Core Machines":
                coreMachines
            case "Other":
                other
            default:
                unknown
            }
            Spacer()
            timer
                .padding()
            Spacer()
        }
        .navigationTitle(exercise)
        .padding(.top, 25)
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }
}

private extension RecordExerciseView {
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

private extension RecordExerciseView {
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
            if exercise == "Row Machine" {
                Divider()
                HStack {
                    Section(header: Text("Chest Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            } else {
                Divider()
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            }
            Divider()
            HStack {
                Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Sets", selection: $viewModel.sets) {
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
}

private extension RecordExerciseView {
    var legMachines: some View {
        VStack {
            Divider()
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
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
                Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Sets", selection: $viewModel.sets) {
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
}

private extension RecordExerciseView {
    var coreMachines: some View {
        VStack {
            Divider()
            if exercise == "Crunch Machine" || exercise == "Torso Rotation" {
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
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            } else {
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            }
            Divider()
            HStack {
                Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Sets", selection: $viewModel.sets) {
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
}

private extension RecordExerciseView {
    var other: some View {
        VStack {
            Divider()
            if exercise == "Freeweights" {
                HStack {
                    Section(header: Text("Exercise/Muscles").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Exercise/Muscles", text: $viewModel.freeWeightExercise)
                            .frame(width: 140)
                            .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                }
                Divider()
                HStack {
                    Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
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
                    }
                    .padding(.horizontal)
                    .padding(.trailing)
                }
                Divider()
                HStack {
                    Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Sets", selection: $viewModel.sets) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
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
            }
            Divider()
        }
    }
}

private extension RecordExerciseView {
    var unknown: some View {
        VStack {
            Text("Cannot find associated category. Please try again")
        }
    }
}

private extension RecordExerciseView {
    var timer: some View {
        VStack {
            Spacer()
            Text(String(format: viewModel.formatMmSs(counter: viewModel.secondsElapsed), viewModel.secondsElapsed))
                .font(.largeTitle)
            switch viewModel.mode {
            case .stopped:
                Button(action: {
                    viewModel.startTimer()
                }) {
                    Text("Start Exercise!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            case .paused:
                Button(action: {
                    viewModel.resetTimer()
                    print("Test")
                }) {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0))
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
                .alert("Are you sure you would like to reset the timer?", isPresented: $viewModel.showResetTimerModal) {
                    Button("NO", role: .destructive) {
                        viewModel.cancelResetTimer()
                    }
                    Button("YES", role: .cancel) {
                        viewModel.confirmResetTimer()
                    }
                }
                Button(action: {
                    viewModel.stopTimer()
                }) {
                    Text("Stop & Record")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
                .alert("Are you sure you want to stop and save this workout?", isPresented: $viewModel.showConfirmSaveWorkoutModal) {
                    Button("NO", role: .destructive) {
                        viewModel.cancelSaveWorkout()
                    }
                    Button("YES", role: .cancel) {
//                        let workout = Workout(context: moc)
//                        workout.id = UUID()
//                        workout.category = viewModel.findCategory(for: exercise)
//                        workout.name = exercise
//                        workout.freeWeightExercise = viewModel.freeWeightExercise
//                        workout.weight = viewModel.weight
//                        workout.adjustment = viewModel.machineSetting
//                        workout.incline = viewModel.inclineLevel
//                        workout.intensity = viewModel.intensityLevel
//                        workout.length = viewModel.secondsElapsed
//                        workout.dateCompleted = Date.now
//                        workout.reps = viewModel.reps
//                        workout.sets = viewModel.sets
//                        try? moc.save()
//                        viewModel.confirmSaveWorkout()
//                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Button(action: {
                    viewModel.startTimer()
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            case .running:
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct RecordExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        RecordExerciseView(exercise: "Freeweights")
    }
}
