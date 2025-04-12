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

    var totalTime: TimeInterval {
        sessions.reduce(0) { $0 + ($1.duration) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Practice Stats")
                .font(.largeTitle)
                .bold()

            Text("⏱ Total Practice Time: \(formattedDuration(totalTime))")
                .font(.title3)

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

                        if let note = session.note, !note.isEmpty {
                            Text("💬 \(note)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
    }

    // Formatters
    private func formattedDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
