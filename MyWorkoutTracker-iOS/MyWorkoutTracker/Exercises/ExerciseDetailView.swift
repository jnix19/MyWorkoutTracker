//
//  ExerciseDetailView.swift
//  MyWorkoutTracker
//
//  Created by Jacob Nix on 12/3/25.
//

import SwiftUI

struct ExerciseDetailView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray5))
                .shadow(radius: 5)
            Text("Exercise Details")
        }
        .frame(width: 320, height: 500)
        .shadow(radius: 1)
    }
}

#Preview {
    ExerciseDetailView()
}
