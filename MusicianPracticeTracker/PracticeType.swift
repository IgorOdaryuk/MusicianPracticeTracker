//
//  PracticeType.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import Foundation

enum PracticeType: String, CaseIterable, Identifiable {
    case scales = "Scales"
    case etudes = "Etudes"
    case technique = "Technique"
    case improvisation = "Improvisation"
    case repertoire = "Repertoire"

    var id: String { rawValue }
}
