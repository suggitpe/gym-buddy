CREATE TABLE Exercises (
    id UUID PRIMARY KEY,
    name TEXT,
    last_weight REAL,
    last_reps INTEGER
);

CREATE TABLE PerformanceLogs (
    id UUID PRIMARY KEY,
    exercise_id REFERENCES Exercises(id),
    actual_weight REAL,
    actual_reps INTEGER,
    avg_heart_rate INTEGER,
    timestamp DATETIME
);