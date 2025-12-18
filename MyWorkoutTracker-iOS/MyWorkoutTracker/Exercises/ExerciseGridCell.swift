//
//  ExerciseGridCell.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 11/14/25.
//

import SwiftUI

struct ExerciseGridCell: View {
    
    let exerciseName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThickMaterial)
            .frame(width: 170, height: 50)
            .overlay(
                Text(exerciseName)
                    .font(.system(size: 18, weight: .bold))
                    .textCase(.uppercase)
                    .foregroundStyle(.wtPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            )
    }
}

#Preview {
    ExerciseGridCell(exerciseName: "Incline Bench Press")
}
