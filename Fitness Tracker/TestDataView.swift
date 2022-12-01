import SwiftUI
import CoreData

struct TestDataView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Workout.entity(), sortDescriptors: [])
    private var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { item in
                    NavigationLink {
                        Text(item.name ?? "Nothing")
                        Text("Sets: \(String(item.sets))")
                        Text("Reps: \(item.reps)")
                    } label: {
                        Text(item.dateCompleted!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.id = UUID()
            newWorkout.dateCompleted = Date.now
            newWorkout.category = randomString(length: 10)
            newWorkout.name = randomString(length: 6)
            newWorkout.length = randomDouble()
            newWorkout.adjustment = randomInt()
            newWorkout.freeWeightExercise = randomString(length: 15)
            newWorkout.intensity = randomDouble()
            newWorkout.incline = randomDouble()
            newWorkout.weight = randomString(length: 2)
            newWorkout.sets = randomInt()
            newWorkout.reps = randomString(length: 2)
            // MARK: when changing attributes, I will need to delete all items in the database. If not, I will see errors
            
            // functions for random data
            func randomString(length: Int) -> String {
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                return String((0..<length).map{ _ in letters.randomElement()! })
            }
            
            func randomDouble() -> Double {
                let randomDouble = Double.random(in: 0.0 ..< 60.0)
                return round(randomDouble * 10) / 10.0
            }
            
            func randomInt() -> Int16 {
                return Int16.random(in: 0 ..< 25)
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct TestDataView_Previews: PreviewProvider {
    static var previews: some View {
        TestDataView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
