import SwiftUI

struct ExercisesListView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.searchResults, id: \.self) { data in
                    Section(header: Text(data.exerciseCategory)) {
                        ForEach(data.exercisesOptions, id: \.self) { exc in
                            NavigationLink(destination: RecordExerciseView(exercise: exc)) {
                                Text(exc)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Choose Your Exercise")
        .environmentObject(viewModel)
    }
}

struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView()
    }
}
