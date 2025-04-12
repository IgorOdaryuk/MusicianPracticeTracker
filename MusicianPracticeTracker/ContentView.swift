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

                // 👇 ДОБАВИЛИ: Переход на статистику
                NavigationLink(destination: StatsView()) {
                    Text("📈 View Stats")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
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
