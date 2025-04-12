//
//  ContentView.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedType: PracticeType = .scales

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

                Button(action: {
                    print("Start practice for \(selectedType.rawValue)")
                }) {
                    Text("Start Practice")
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
