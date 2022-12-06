import SwiftUI

extension ExercisesListView {
    final class ViewModel: ObservableObject {
        
        @Published var searchText = ""
        
        var data: [Exercises] = [
            .init(exerciseCategory: "Cardio Machines", exercisesOptions: [
                "Treadmill",
                "Elliptical",
                "Stairclimber",
                "Stationary Bike",
                "Recumbent Bike",
                "ARC Trainer"
            ]),
            .init(exerciseCategory: "Arm, Shoulder & Chest Machines", exercisesOptions: [
                "Bicep Curl Station",
                "Shoulder Press",
                "Bicep and Tricep Cable Car",
                "Chest Press",
                "Lateral Pull-down Machine",
                "Butterfly Machine",
                "Incline Press",
                "Row Machine",
                "Triceps Press"
            ]),
            .init(exerciseCategory: "Leg Machines", exercisesOptions: [
                "Seated Leg Press",
                "Angled Leg Curl Machine",
                "Leg Extension Machine",
                "Sled Push",
                "Calf Extension"
            ]),
            .init(exerciseCategory: "Core Machines", exercisesOptions: [
                "Crunch Machine",
                "Torso Rotation",
                "Mountain Climber Machine",
                "Decline Bench",
                "Hanging Leg Raise Station"
            ]),
            .init(exerciseCategory: "Other", exercisesOptions: [
                "Freeweights",
                "Walking",
                "Runnning",
                "Hiking",
                "Biking",
                "Yoga",
                "Stretching"
            ])
        ]
        
        var searchResults: [Exercises] {
                if searchText.isEmpty {
                    return data
                } else {
                    var allExcercises: [String] = []
                    for cat in data {
                        for exc in cat.exercisesOptions {
                            allExcercises.append(exc)
                        }
                    }
                    let filteredExcercises = allExcercises.filter { $0.contains(searchText) }
                    return [Exercises(exerciseCategory: "Filtered List", exercisesOptions: filteredExcercises)]
                    // currently does not return each exercise in its respective category. Would need more logic to impliment that, but it is probably not needed at this point
                }
            }
        
    }
}
