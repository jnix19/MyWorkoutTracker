//
//  WTTabView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 10/23/25.
//

import SwiftUI

struct WTTabView: View {
    var body: some View {
        TabView {
            //workouts tab
            Tab("Workouts", systemImage: "dumbbell.fill") {
                WorkoutListView(workouts: [SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample3])
            }
            
            //exercises tab
            Tab("Exercises", systemImage: "chart.line.uptrend.xyaxis") {
                ExerciseGridView(exercises: [SampleExercises.benchPressExample, SampleExercises.deadliftExample, SampleExercises.squatExample])
            }
        }
        .tint(.wtPrimary)
        .colorScheme(.dark)
    }
}

#Preview {
    WTTabView()
        
}
