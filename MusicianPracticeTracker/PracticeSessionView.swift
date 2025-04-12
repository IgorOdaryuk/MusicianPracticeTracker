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
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @State private var startTime = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var note: String = ""
    @State private var sessionSaved: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("🧘 Practicing \(practiceType.rawValue)")
                .font(.title)
                .padding(.top)

            Text(formattedTime)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()

            Text("💬 Comment (optional):")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)

            TextEditor(text: $note)
                .frame(height: 100)
                .padding(4)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

            Button("Stop Practice") {
                elapsedTime = Date().timeIntervalSince(startTime)
                timer?.invalidate()
                timer = nil

                let newSession = PracticeSession(context: viewContext)
                newSession.id = UUID()
                newSession.type = practiceType.rawValue
                newSession.duration = elapsedTime
                newSession.date = Date()
                newSession.note = note

                do {
                    try viewContext.save()
                    print("✅ Practice session saved.")
                    sessionSaved = true
                } catch {
                    print("⚠️ Failed to save session: \(error.localizedDescription)")
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            if sessionSaved {
                Button("← Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.top, 8)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsedTime = Date().timeIntervalSince(startTime)
            }
            RunLoop.main.add(timer!, forMode: .common)
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
