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
            exercises[workout.dateRange ?? "Uknown Range"]?.append(workout)
        }
        // need to sort ranges
        return exercises
    }
    
    func getDateRange() -> [BreakdownHistoryGraph] {
        var breakdownHistoryGraphs: [BreakdownHistoryGraph] = []
        for range in getExercisesForEachRange().keys {
            breakdownHistoryGraphs.append(BreakdownHistoryGraph(dateRange: range, minutesPerDay: nil, graphs: nil))
        }
        return breakdownHistoryGraphs
    }
    
//    func getTotalTimes() -> [BreakdownHistoryGraph] {
//        var graphs: [BreakdownHistoryGraph] = []
//        for workout in workouts {
//            graphs.append(BreakdownHistoryGraph(dateRange: nil, minutesPerDay: [
//                minutesPerDay(dayOfWeek: .mon, time: week.minutesMon),
//                minutesPerDay(dayOfWeek: .tue, time: week.minutesTue),
//                minutesPerDay(dayOfWeek: .wed, time: week.minutesWed),
//                minutesPerDay(dayOfWeek: .thu, time: week.minutesThu),
//                minutesPerDay(dayOfWeek: .fri, time: week.minutesFri),
//                minutesPerDay(dayOfWeek: .sat, time: week.minutesSat),
//                minutesPerDay(dayOfWeek: .sun, time: week.minutesSun),
//            ], graphs: nil))
//        }
//        return graphs
//    }
    
    var body: some View {
        if getDateRanges().isEmpty {
            Text("Sorry, there is no data to display.")
        } else {
            List(getDateRange(), children: \.graphs) { week in
                    HStack {
                        if week.dateRange != nil {
                            Text(week.dateRange ?? "")
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
