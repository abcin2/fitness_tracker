import SwiftUI

struct BreakdownHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    // dummy data to use for testing
    let graphOne: BreakdownHistoryGraph = .init(dateRange: nil, minutesPerDay: 26.8, graphs: nil)
    let graphTwo: BreakdownHistoryGraph = .init(dateRange: nil, minutesPerDay: 23.0, graphs: nil)
    let graphThree: BreakdownHistoryGraph = .init(dateRange: nil, minutesPerDay: 34.2, graphs: nil)
    
    var body: some View {
        let breakdownHistoryGraphs: [BreakdownHistoryGraph] = [
            BreakdownHistoryGraph(dateRange: "Week 1", minutesPerDay: nil, graphs: [graphOne, graphTwo, graphThree]),
            BreakdownHistoryGraph(dateRange: "Week 2", minutesPerDay: nil, graphs: [graphOne, graphTwo, graphThree]),
            BreakdownHistoryGraph(dateRange: "Week 2", minutesPerDay: nil, graphs: [graphOne, graphTwo, graphThree])
        ]
        if viewModel.weeksOf.count == 0 {
            Text("Sorry, there is no data to display.")
        } else {
            List(breakdownHistoryGraphs, children: \.graphs) { week in
                HStack {
                    if week.dateRange != nil {
                        Text(week.dateRange ?? "")
                    } else {
                        Text(String(week.minutesPerDay ?? 0.0))
                    }
                }
            }
        }
    }
}

struct BreakdownHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownHistoryView()
    }
}
