import Charts
import SwiftUI

struct BreakdownHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)]) var workouts: FetchedResults<Workout>
    @FetchRequest(sortDescriptors: []) var previousWeeks: FetchedResults<PreviousWeek>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()

    // using fetched data to create the same objects
    func getDateRange() -> [BreakdownHistoryGraph] {
        var breakdownHistoryGraphs: [BreakdownHistoryGraph] = []
        for week in previousWeeks {
            breakdownHistoryGraphs.append(BreakdownHistoryGraph(dateRange: week.weekOf, minutesPerDay: nil, graphs: getTotalTimes()))
        }
        return breakdownHistoryGraphs
    }
    
    func getTotalTimes() -> [BreakdownHistoryGraph] {
        var graphs: [BreakdownHistoryGraph] = []
        for week in previousWeeks {
            graphs.append(BreakdownHistoryGraph(dateRange: nil, minutesPerDay: [
                minutesPerDay(dayOfWeek: .mon, time: week.minutesMon),
                minutesPerDay(dayOfWeek: .tue, time: week.minutesTue),
                minutesPerDay(dayOfWeek: .wed, time: week.minutesWed),
                minutesPerDay(dayOfWeek: .thu, time: week.minutesThu),
                minutesPerDay(dayOfWeek: .fri, time: week.minutesFri),
                minutesPerDay(dayOfWeek: .sat, time: week.minutesSat),
                minutesPerDay(dayOfWeek: .sun, time: week.minutesSun),
            ], graphs: nil))
        }
        return graphs
    }
    
    var body: some View {
        if viewModel.weeksOf.count == 0 {
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
