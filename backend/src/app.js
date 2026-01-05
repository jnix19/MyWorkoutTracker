// Jacob Nix
// Workout Tracker App

import express from "express";
import pkg from "pg";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();
const { Pool } = pkg;

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Test endpoint
app.get("/", (req, res) => {
  res.send("Workout Tracker API is running 🚀");
});

// Create a new user
app.post("/users", async (req, res) => {
  const { username } = req.body;
  try {
    const result = await pool.query(
      "INSERT INTO users (username) VALUES ($1) RETURNING *",
      [username]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

// Get all users
app.get("/users", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM users ORDER BY id ASC");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

// Add a new exercise to the library
app.post("/exercises", async (req, res) => {
  const { name } = req.body;
  try {
    const result = await pool.query(
      `INSERT INTO exercises (name) VALUES ($1) RETURNING *`,
      [name]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all exercises in the library
app.get("/exercises", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM exercises");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Add a new workout with exercises
app.post("/workouts", async (req, res) => {
  const { user_id, workout_name, exercises, workout_date } = req.body;
  try {
    // Insert the workout
    const workoutResult = await pool.query(
      `INSERT INTO workouts (user_id, workout_name, workout_date) VALUES ($1, $2, $3) RETURNING *`,
      [user_id, workout_name, workout_date || new Date()]
    );
    const workout = workoutResult.rows[0];

    // Insert the exercises for this workout into workout_exercises
    for (const exercise of exercises) {
      const { exercise_id, sets, reps, weight } = exercise;
      await pool.query(
        `INSERT INTO workout_exercises (workout_id, exercise_id, sets, reps, weight)
         VALUES ($1, $2, $3, $4, $5)`,
        [workout.id, exercise_id, sets, reps, weight]
      );
    }

    res.status(201).json({ message: "Workout added successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all workouts for a user
app.get("/workouts/:user_id", async (req, res) => {
  const { user_id } = req.params;
  try {
    const workoutResults = await pool.query(
      `SELECT * FROM workouts WHERE user_id = $1 ORDER BY workout_date DESC`,
      [user_id]
    );

    const workouts = workoutResults.rows;
    for (const workout of workouts) {
      const exerciseResults = await pool.query(
        `SELECT we.sets, we.reps, we.weight, e.name AS exercise_name
         FROM workout_exercises we
         JOIN exercises e ON we.exercise_id = e.id
         WHERE we.workout_id = $1`,
        [workout.id]
      );
      workout.exercises = exerciseResults.rows;
    }

    res.json(workouts);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get stats for a specific exercise
app.get("/exercise-stats/:exercise_id", async (req, res) => {
  const { exercise_id } = req.params;
  try {
    const stats = await pool.query(
      `SELECT COUNT(*) AS times_performed, MAX(weight) AS heaviest_weight
       FROM workout_exercises WHERE exercise_id = $1`,
      [exercise_id]
    );
    res.json(stats.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = 3001;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));