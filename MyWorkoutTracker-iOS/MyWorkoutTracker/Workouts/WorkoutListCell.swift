//
//  WorkoutListCell.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 11/13/25.
//

import SwiftUI

struct WorkoutListCell: View {
    
    let workout: Workout
    
    var body: some View {
        HStack{
            Text(workout.name)
                .font(.title2)
                .bold()
                .foregroundStyle(.wtPrimary)
            Spacer()
            Text(workout.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                .font(.headline)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutListCell(workout: SampleWorkouts.workoutExample1)
}
