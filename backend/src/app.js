//Jacob Nix
//Workout Tracker App

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

//Test endpoint
app.get("/", (req, res) => {
  res.send("Workout Tracker API is running 🚀");
});

//Example: get all workouts
app.get("/workouts", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM workouts");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

//Create a new user
app.post('/users', async (req, res) => {
  const { username } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO users (username) VALUES ($1) RETURNING *',
      [username]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
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

// Log a new workout for a user
app.post("/workouts", async (req, res) => {
  const { user_id, exercise_id, sets, reps, weight, workout_date } = req.body;

  if (!user_id || !exercise_id || !sets || !reps) {
    return res.status(400).json({ error: "user_id, exercise_id, sets, and reps are required." });
  }

  try {
    // build query dynamically so we only include workout_date if it's provided
    let query, values;
    if (workout_date) {
      query = `
        INSERT INTO workouts (user_id, exercise_id, sets, reps, weight, workout_date)
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING *`;
      values = [user_id, exercise_id, sets, reps, weight || null, workout_date];
    } else {
      query = `
        INSERT INTO workouts (user_id, exercise_id, sets, reps, weight)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING *`;
      values = [user_id, exercise_id, sets, reps, weight || null];
    }

    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

// Get all workouts for a specific user
app.get("/workouts/:user_id", async (req, res) => {
  const { user_id } = req.params;

  try {
    const result = await pool.query(
      `SELECT w.id, e.name AS exercise, w.sets, w.reps, w.weight, w.workout_date
       FROM workouts w
       LEFT JOIN exercises e ON w.exercise_id = e.id
       WHERE w.user_id = $1
       ORDER BY w.workout_date DESC`,
      [user_id]
    );

    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

// Add a new exercise
app.post("/exercises", async (req, res) => {
  const { name } = req.body;

  if (!name) return res.status(400).json({ error: "Exercise name required" });

  try {
    const result = await pool.query(
      "INSERT INTO exercises (name) VALUES ($1) RETURNING *",
      [name]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

// Get all exercises
app.get("/exercises", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM exercises ORDER BY id ASC");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));