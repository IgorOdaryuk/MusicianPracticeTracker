//
//  PracticeSessionView.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import SwiftUI
import CoreData

struct PracticeSessionView: View {
    let practiceType: PracticeType
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @State private var startTime = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("🧘 Practicing \(practiceType.rawValue)")
                .font(.title)
                .padding(.top)

            Text(formattedTime)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()

            Button("Stop Practice") {
                // Останавливаем таймер
                timer?.invalidate()
                timer = nil

                // Сохраняем в CoreData
                let newSession = PracticeSession(context: viewContext)
                newSession.id = UUID()
                newSession.type = practiceType.rawValue
                newSession.duration = elapsedTime
                newSession.date = Date()

                do {
                    try viewContext.save()
                    print("✅ Practice session saved.")
                } catch {
                    print("⚠️ Failed to save session: \(error.localizedDescription)")
                }

                // Закрываем экран
                dismiss()
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
        .onAppear {
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
