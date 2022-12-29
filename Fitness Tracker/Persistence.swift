import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newWorkout = Workout(context: viewContext)
            newWorkout.id = UUID()
            newWorkout.dateCompleted = Date.now
            newWorkout.dateRange = randomString(length: 15)
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
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Fitness_Tracker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
