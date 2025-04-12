import SwiftUI

struct ContentView: View {
    @State private var selectedType: PracticeType = .scales
    @State private var isPracticing = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("🎵 Choose Practice Type")
                    .font(.title2)
                    .bold()

                Picker("Practice Type", selection: $selectedType) {
                    ForEach(PracticeType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.wheel)
                .padding()

                // Using deprecated NavigationLink with isActive for compatibility with iOS versions prior to 16.
                // NavigationStack and .navigationDestination are iOS 16+, which would limit backward compatibility.

                NavigationLink(
                    destination: PracticeSessionView(practiceType: selectedType),
                    isActive: $isPracticing
                ) {
                    Button("Start Practice") {
                        isPracticing = true
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Musician Tracker")
        }
    }
}

#Preview {
    ContentView()
}
