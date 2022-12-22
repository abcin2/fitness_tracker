import Charts
import SwiftUI

struct BreakdownHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()

    // go through each workout
    // put date ranges in a set?
    // if workout.dateRange is equal to each, assign minutes to respective days
    func getDateRanges() -> Set<String> {
        var ranges: Set<String> = []
        for workout in workouts {
            ranges.insert(workout.dateRange ?? "Uknown Range")
        }
        // need to sort ranges
        return ranges
    }
    
    func getExercisesForEachRange() -> [String:[Workout]] {
        var exercises: [String:[Workout]] = [:]
        for workout in workouts {
            if exercises[workout.dateRange ?? "Uknown Range"] != nil {
                exercises[workout.dateRange ?? "Uknown Range"]?.append(workout)
            } else {
                exercises[workout.dateRange ?? "Uknown Range"] = [workout]
            }
        }
        // need to sort ranges
        return exercises
    }
    
    func getDateRange() -> [BreakdownHistoryGraph] {
        var breakdownHistoryGraphs: [BreakdownHistoryGraph] = []
        for range in getExercisesForEachRange().keys {
            breakdownHistoryGraphs.append(BreakdownHistoryGraph(dateRange: range, minutesPerDay: nil, graphs: getTotalTimes()))
        }
        return breakdownHistoryGraphs
    }
    
    func getTotalTimes() -> [BreakdownHistoryGraph] {
        var graphs: [BreakdownHistoryGraph] = []
        for range in getDateRanges() {
            var secondsPerDay: [String:Double] = [
                "Mon": 0.0,
                "Tue": 0.0,
                "Wed": 0.0,
                "Thu": 0.0,
                "Fri": 0.0,
                "Sat": 0.0,
                "Sun": 0.0
            ]
            for workout in workouts {
                if workout.dateRange == range {
                    switch workout.dateCompleted?.formatted(.dateTime.weekday()) {
                    case "Mon":
                        secondsPerDay["Mon"]! += workout.length
                    case "Tue":
                        secondsPerDay["Tue"]! += workout.length
                    case "Wed":
                        secondsPerDay["Wed"]! += workout.length
                    case "Thu":
                        secondsPerDay["Thu"]! += workout.length
                    case "Fri":
                        secondsPerDay["Fri"]! += workout.length
                    case "Sat":
                        secondsPerDay["Sat"]! += workout.length
                    case "Sun":
                        secondsPerDay["Sun"]! += workout.length
                    default:
                        secondsPerDay["Uknown"]! += workout.length
                    }
                }
            }
            graphs.append(BreakdownHistoryGraph(dateRange: nil, minutesPerDay: [
                minutesPerDay(dayOfWeek: .mon, time: (secondsPerDay["Mon"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .tue, time: (secondsPerDay["Tue"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .wed, time: (secondsPerDay["Wed"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .thu, time: (secondsPerDay["Thu"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .fri, time: (secondsPerDay["Fri"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .sat, time: (secondsPerDay["Sat"] ?? 0.0) / 60),
                minutesPerDay(dayOfWeek: .sun, time: (secondsPerDay["Sun"] ?? 0.0) / 60)
            ], graphs: nil))
        }
        return graphs
    }
    
    var body: some View {
        if getDateRange().isEmpty {
            Text("Sorry, there is no data to display.")
        } else {
            List(getDateRange(), children: \.graphs) { week in
                    HStack {
                        if week.dateRange != nil {
                            Text(week.dateRange ?? "test")
                        } else {
                            Chart {
                                BarMark (
                                    x: .value("Day", "Mon"),
                                    y: .value("Total Minutes", week.minutesPerDay?[0].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Tue"),
                                    y: .value("Total Minutes", week.minutesPerDay?[1].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Wed"),
                                    y: .value("Total Minutes", week.minutesPerDay?[2].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Thu"),
                                    y: .value("Total Minutes", week.minutesPerDay?[3].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Fri"),
                                    y: .value("Total Minutes", week.minutesPerDay?[4].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Sat"),
                                    y: .value("Total Minutes", week.minutesPerDay?[5].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Sun"),
                                    y: .value("Total Minutes", week.minutesPerDay?[6].time ?? 0.0)
                                )
                            }
                            .frame(height: 250)
                        }
                    }
                    // should check if any time exists in the week
                    // if not, do not display week at all
                }
            }
        }
    }


struct BreakdownHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownHistoryView()
    }
}
