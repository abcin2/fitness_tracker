import SwiftUI

struct StartScreenView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Fitness Tracker")
                    .font(.largeTitle)
                    .fontWeight(.light)
                Spacer()
                Image(systemName: "figure.run")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.accentColor)
                Spacer()
                Spacer()
                NavigationLink(destination: DashboardView()) {
                    Text("Start Tracking!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct StartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreenView()
    }
}
