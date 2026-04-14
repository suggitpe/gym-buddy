# VocalLift-AI

**Version:** 1.0.0

**Description:** Voice-activated gym tracker with background music integration and Fitbit sync.

## Architecture

This project is built using **Kotlin-Multiplatform (KMP)**.

## Tech Stack

*   **Shared Logic:** Kotlin commonMain
*   **Database:** SQLDelight
*   **AI Engine:** Gemini 3 Flash (Remote) + Whisper (Local fallback)
*   **Biometrics:** Fitbit Web API + Health Connect (Android)
*   **Audio Engine:** Native AVAudioSession (iOS) / AudioManager (Android)

## Features

*   Voice-activated workout tracking
*   Background music integration with automatic volume adjustment
*   Fitbit integration for biometric data tracking
*   Workout performance logging

## Database Schema

```sql
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
```

## Voice Intents

The following voice intents are supported:

```json
{
  "intents": [
    {
      "intent": "LOG_SET",
      "utterances": ["Done", "That was 10 reps at 80kg", "Finished that set"],
      "slots": ["reps", "weight", "rpe"]
    },
    {
      "intent": "ADJUST_PLAN",
      "utterances": ["That was too heavy", "I'm feeling tired", "Skip core today"],
      "action": "modify_session_queue"
    },
    {
      "intent": "BIO_REPORT",
      "utterances": ["What's my heart rate?", "Check my Fitbit"],
      "action": "fetch_wearable_data"
    }
  ]
}
```

## Fitbit Integration

*   **Activity Type:** Weight_Lifting
*   **Sync Event:** WORKOUT_COMPLETE
*   **Data Points:**
    *   calories_burned
    *   heart_rate_zones
    *   duration_minutes
*   **Authentication:** OAuth2_PKCE

## Audio Policy

The application uses the following audio policy for managing music and microphone levels:

```yaml
audio_states:
  IDLE: { music_volume: 1.0, mic_active: false }
  LISTENING: { music_volume: 0.2, mic_active: true }
  SPEAKING: { music_volume: 0.2, mic_active: false }

transition_speed: 300ms
ducking_type: "Transient_Lower"
```

## AI Personality

The AI assistant has the following personality and operating instructions:

**Role:** Advisory Gym Conductor

You are a technical, supportive, and concise fitness advisor.

**Operating Instructions:**

1.  **Audio Protocol**: Before speaking, always issue the `AUDIO_DUCK` command to lower the music.
2.  **Context**: You have access to the user's Fitbit HR data and their previous workout logs.
3.  **The Voice**: Use an "Advisory" tone. Instead of "Good job," say "Target volume achieved; recovery HR is optimal."
4.  **Safety**: If HR > 175 BPM, automatically suggest an extra 30 seconds of rest.
5.  **Brevity**: Never speak more than two sentences at a time. The user is training.

## Setup Instructions

This is a Kotlin Multiplatform project. To get started, you will need to have the following installed:

*   Android Studio
*   Xcode
*   Kotlin Multiplatform Mobile plugin for Android Studio

Once you have the prerequisites, you can clone the repository and open it in Android Studio.

## Running the application

### Android

To run the application on an Android device or emulator:
1. Open the project in Android Studio.
2. Select the `androidApp` run configuration.
3. Choose a target device or emulator.
4. Click the "Run" button.

### iOS

To run the application on an iOS device or simulator:
1. Open the project in Android Studio.
2. Select the `iosApp` run configuration.
3. Choose a target device or simulator.
4. Click the "Run"button.

Alternatively, you can run the app from Xcode:
1. Open the `iosApp/iosApp.xcworkspace` file in Xcode.
2. Select a target device or simulator.
3. Click the "Run" button.
