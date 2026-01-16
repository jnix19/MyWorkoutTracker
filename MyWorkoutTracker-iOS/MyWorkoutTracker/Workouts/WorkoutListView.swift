//
//  WorkoutListView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 11/11/25.
//

import SwiftUI

struct WorkoutListView: View {
    
    @State var workouts: [Workout] = []
        
    var body: some View {
        
        NavigationStack {
            List(workouts) { workout in
                NavigationLink{
                    WorkoutDetailView(workout: workout)
                } label: {
                    WorkoutListCell(workout: workout)
                }
            }
            .padding(.top)
            .navigationTitle("Workouts")
            .listRowSpacing(8)
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    WorkoutListView(workouts: [SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample2, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample3, SampleWorkouts.workoutExample1, SampleWorkouts.workoutExample2])
}
