//
//  WorkoutDetailView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 11/14/25.
//

import SwiftUI

struct WorkoutDetailView: View {
    
    let workout: Workout
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.black, .wtPrimary], startPoint: .top, endPoint: .bottom))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.primary.opacity(0.75), style: StrokeStyle(lineWidth: 1))
                )
            
            VStack {
                //title and date
                HStack {
                    Text(workout.name)
                        .font(.title.bold())
                        .foregroundStyle(.wtPrimary)
                    Spacer()
                    Text(workout.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 10)
                
                ScrollView {
                    ForEach(workout.exercises) { exercise in
                        HStack {
                            Text(exercise.name)
                                .font(.title3.bold())
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            VStack {
                                Text("Sets: " + String(exercise.sets))
                                Text("Reps: " + String(exercise.reps))
                                Text("Weight: " + String(format: "%.0f", exercise.weight ?? "N/A"))
                            }
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal, 15)
            }
            .frame(width: 320, height: 500, alignment: .top)
        }
        .frame(width: 320, height: 500)
        .shadow(radius: 1)
    }
}

#Preview {
    WorkoutDetailView(workout: SampleWorkouts.workoutExample1)
}
