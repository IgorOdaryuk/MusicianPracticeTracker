//
//  StatsView.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import SwiftUI
import CoreData

struct StatsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PracticeSession.date, ascending: false)],
        animation: .default
    )
    private var sessions: FetchedResults<PracticeSession>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("⏱ Total Practice Time: \(formattedDuration(totalDuration))")
                .font(.headline)
                .padding(.horizontal)

            List {
                ForEach(sessions) { session in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.type ?? "Unknown")
                            .font(.headline)

                        Text("⏱ \(formattedDuration(session.duration))")
                            .font(.subheadline)

                        Text("📅 \(formattedDate(session.date))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Practice Stats")
    }

    // Сумма всех длительностей
    var totalDuration: Double {
        sessions.reduce(0) { $0 + $1.duration }
    }

    func formattedDuration(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "No date" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
