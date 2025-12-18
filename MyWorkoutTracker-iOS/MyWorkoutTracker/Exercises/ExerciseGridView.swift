//
//  ExerciseGridView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 11/11/25.
//

import SwiftUI

struct ExerciseGridView: View {
    
    @State var exercises: [Exercise] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(exercises) { exercise in
                        ExerciseGridCell(exerciseName: exercise.name)
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Exercises")
            .listRowSpacing(8)
            .listStyle(.grouped)
        }
    }
}

#Preview {
    ExerciseGridView(exercises: [SampleExercises.benchPressExample, SampleExercises.deadliftExample, SampleExercises.squatExample])
}
