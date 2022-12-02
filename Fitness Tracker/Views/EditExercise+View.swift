import Combine
import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [])
    var workouts: FetchedResults<Workout>
    @ObservedObject var workout: Workout
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            VStack {
                Text("Exercise Time:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Divider()
                // all workouts will have an option to edit the amount of time
                HStack {
                    Section(header: Text("Minutes").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("", text: $viewModel.minutesElapsedString)
                            .frame(width: 35)
                    }
                    .padding(.horizontal)
                }
                Divider()
                HStack {
                    Section(header: Text("Seconds").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("", text: $viewModel.secondsElapsedString)
                            .frame(width: 35)
                    }
                    .padding(.horizontal)
                }
                Divider()
            }
            .padding(.vertical)
            switch workout.category {
            case "Cardio Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    cardioMachines
                }
                .padding(.vertical)
            case "Arm, Shoulder & Chest Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    ASCMachines
                }
                .padding(.vertical)
            case "Leg Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    legMachines
                }
                .padding(.vertical)
            case "Core Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    coreMachines
                }
                .padding(.vertical)
            case "Other":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    other
                }
                .padding(.vertical)
            default:
                unknown
            }
            Spacer()
            HStack {
                Button(action: {
                    moc.delete(workout)
                    try? moc.save()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            HStack {
                Button(action: {
                    if let exercise = workouts.first(where: {$0.name == workout.name}) {
                        exercise.freeWeightExercise = viewModel.freeWeightExercise
                        exercise.weight = viewModel.weight
                        exercise.adjustment = viewModel.machineSetting
                        exercise.incline = viewModel.inclineLevel
                        exercise.intensity = viewModel.intensityLevel
                        exercise.length = viewModel.formatTimeStringBackToDouble(minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        exercise.dateCompleted = Date.now
                        exercise.reps = viewModel.reps
                        exercise.sets = viewModel.sets
                        try? moc.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save Changes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            // need function to convert this string BACK to an int
        }
        .navigationTitle(workout.name ?? "Unknown")
        .padding(.vertical)
        .onAppear {
            viewModel.initializeDataFromCoreDataWorkout(with: workout)
        }
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }
}

private extension EditExerciseView {
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

private extension EditExerciseView {
    var ASCMachines: some View {
        VStack {
            Divider()
            HStack {
                Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("Weight", text: $viewModel.weight)
                        .keyboardType(.numberPad)
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
            }
            if workout.name == "Row Machine" {
                Divider()
                HStack {
                    Section(header: Text("Chest Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
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
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            }
            Divider()
            HStack {
                Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Machine Setting", selection: $viewModel.machineSetting) {
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
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
                }
                .padding(.horizontal)
                .padding(.vertical, -3)
            }
            Divider()
            HStack {
                Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Reps", selection: $viewModel.reps) {
                        ForEach(viewModel.repOptions, id: \.self) { number in
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

private extension EditExerciseView {
    var legMachines: some View {
        VStack {
            Divider()
            HStack {
                Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("Weight", text: $viewModel.weight)
                        .keyboardType(.numberPad)
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
            }
            Divider()
            HStack {
                Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Machine Setting", selection: $viewModel.machineSetting) {
                        ForEach(viewModel.oneThroughTen, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
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
                }
                .padding(.horizontal)
                .padding(.vertical, -3)
            }
            Divider()
            HStack {
                Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Reps", selection: $viewModel.reps) {
                        ForEach(viewModel.repOptions, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                }
                .padding(.horizontal)
            }
            Divider()
        }
    }
}

private extension EditExerciseView {
    var coreMachines: some View {
        VStack {
            Divider()
            if workout.name == "Crunch Machine" || workout.name == "Torso Rotation" {
                HStack {
                    Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Weight", text: $viewModel.weight)
                            .keyboardType(.numberPad)
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
                }
                Divider()
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
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
                }
                .padding(.horizontal)
                .padding(.vertical, -3)
            }
            Divider()
            HStack {
                Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Reps", selection: $viewModel.reps) {
                        ForEach(viewModel.repOptions, id: \.self) { number in
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

private extension EditExerciseView {
    var other: some View {
        VStack {
            Divider()
            if workout.name == "Freeweights" {
                HStack {
                    Section(header: Text("Exercise/Muscles").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Exercise/Muscles", text: $viewModel.freeWeightExercise)
                            .frame(width: 140)
                    }
                    .padding(.horizontal)
                }
                Divider()
                HStack {
                    Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Weight", text: $viewModel.weight)
                            .keyboardType(.numberPad)
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
                }
                Divider()
                HStack {
                    Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Sets", selection: $viewModel.sets) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
                HStack {
                    Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Reps", selection: $viewModel.reps) {
                            ForEach(viewModel.repOptions, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
            }
            Divider()
        }
    }
}

private extension EditExerciseView {
    var unknown: some View {
        VStack {
            Text("Cannot find associated category. Please try again")
        }
    }
}

//struct EditExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExerciseView(workout: Workout)
//    }
//}
