//
//  ExerciseDetailView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 12/3/25.
//

import SwiftUI

struct ExerciseDetailView: View {
    
    let exercise: Exercise
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray5))
                .shadow(radius: 5)
            Text(exercise.name)
        }
        .frame(width: 320, height: 600)
        .shadow(radius: 1)
    }
}

#Preview {
    ExerciseDetailView(exercise: SampleExercises.benchPressExample)
}
