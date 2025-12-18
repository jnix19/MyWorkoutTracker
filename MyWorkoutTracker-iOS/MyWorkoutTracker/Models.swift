//
//  Models.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 10/23/25.
//

import Foundation

//displaying workouts fetched from backend
struct Workout: Codable, Identifiable {
    let id: Int
    let name: String
    let exercises: [Exercise]
    let date: Date?
}

//for posting a new workout to the server
struct NewWorkout: Codable {
    var id: Int
    var name: String
    var exercises: [NewExercise]
    var date: Date?
}

//displaying exercise fetched from backend
struct Exercise: Codable, Identifiable {
    let id: Int
    let name: String
    let sets: Int
    let reps: Int
    let weight: Double?
}

//for posting a new exercise
struct NewExercise: Codable {
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double?
}


//MARK: Sample data

struct SampleExercises {
    
    static let benchPressExample = Exercise(id: 1, name: "Bench Press", sets: 2, reps: 10, weight: 225)
    static let squatExample = Exercise(id: 2, name: "Squat", sets: 5, reps: 5, weight: 315)
    static let deadliftExample = Exercise(id: 3, name: "Deadlift", sets: 3, reps: 3, weight: 415)
}

struct SampleWorkouts {
    
    static let workoutExample1 = Workout(id: 1, name: "Full Body", exercises: [SampleExercises.benchPressExample, SampleExercises.squatExample, SampleExercises.deadliftExample], date: Date())
    static let workoutExample2 = Workout(id: 2, name: "Chest Day", exercises: [SampleExercises.benchPressExample, SampleExercises.benchPressExample, SampleExercises.benchPressExample], date: Date())
    static let workoutExample3 = Workout(id: 3, name: "Back Workout", exercises: [SampleExercises.deadliftExample, SampleExercises.deadliftExample, SampleExercises.deadliftExample], date: Date())
}
