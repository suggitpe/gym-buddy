# Development Workflow and Guiding Principles

This document outlines the steering principles for the development of this project. Adhering to these principles ensures consistency, quality, and maintainability across all tasks.

## 1. Guiding Principles

-   **The Plan is the Source of Truth:** All work must be tracked in `plan.md`. This file serves as the definitive record of project tasks, progress, and decisions.
-   **The Tech Stack is Deliberate:** Changes to the project's technology stack must be thoroughly documented in `tech-stack.md` *before* any implementation begins.
-   **User Experience First:** Every design and implementation decision should prioritize the end-user experience, ensuring the product is intuitive, efficient, and enjoyable to use.
-   **Task Granularity:** All tasks defined within tracks should be small enough to be completed and committed in a single cycle.
-   **MVP Scope:** The initial Minimum Viable Product (MVP) should explicitly exclude voice activation and interactions with external data sources.

## 2. Task Lifecycle and TDD-Strict Workflow

All development tasks must strictly follow a Test-Driven Development (TDD) approach and adhere to this defined lifecycle:

### Standard Task Workflow

1.  **Select Task:** Choose the next available task from `plan.md` in sequential order.
2.  **Pre-Task Test Run:** Execute the full test suite to ensure a stable baseline. If any tests fail, stop and fix them before proceeding with the current task.
3.  **Mark In Progress:** After confirming all tests pass, edit `plan.md` and change the task from `[ ]` to `[~]`.
4.  **Write Failing Tests (Red Phase):**
    -   Create a new test file or add to an existing one for the feature or bug fix.
    -   Write one or more unit tests that define the expected behavior.
    -   **CRITICAL:** Run the tests and confirm that they fail as expected.
5.  **Implement to Pass Tests (Green Phase):
    -   Write the minimum amount of code to make the failing tests pass.
    -   Run the test suite again and confirm that all tests now pass.
6.  **Refactor (Optional but Recommended):**
    -   Refactor the implementation and test code to improve clarity and performance. Rerun tests to ensure they still pass.
7.  **Post-Task Test Run:** Execute the full test suite again to prove that the changes have not introduced any regressions.
8.  **Verify Coverage:** Run coverage reports. Target: >75% coverage.
9.  **Document Deviations:** If implementation differs from `tech-stack.md`, stop, update the document, and then resume.
10. **Mark Task Complete in Plan:**
    -   Read `plan.md`, find the line for the completed task, and update its status from `[~]` to `[x]`.
    -   Write the updated content back to `plan.md`.

## 3. Task Completion and Review

**Trigger:** This protocol is executed immediately after a task is marked as complete in `plan.md`.

1.  **Announce Task Completion:** Inform the user that the task is complete and ready for review.
2.  **Display Changes:** Show the user the `git diff` of the changes made during the task.
3.  **Request Review and Commit:** Ask the user to review the changes. If they approve, ask for a commit message or confirmation of a suggested one.
4.  **Commit Changes:** Upon user approval, stage the changes and create the commit using the provided message.
5.  **Confirm Commit:** Show the user the output of `git log -n 1` to confirm the commit was successful before proceeding to the next task.

## 4. Phase Completion Verification and Checkpointing Protocol

**Trigger:** This protocol is executed immediately after the final task in a phase is completed.

1.  **Announce Protocol Start:** Inform the user that the phase is complete and the verification and checkpointing protocol has begun.

2.  **Ensure Test Coverage for Phase Changes:**
    -   Verify that all code changes in the phase meet the 75% coverage requirement.

3.  **Execute Automated Tests with Proactive Debugging:**
    -   Run the full test suite one final time for the phase.
    -   If tests fail, begin debugging.

4.  **Propose a Detailed, Actionable Manual Verification Plan:**
    -   Generate a step-by-step plan for the user to manually verify the functionality of the completed phase.

5.  **Await Explicit User Feedback:**
    -   Pause and await the user's explicit approval of the manual verification.

6.  **Create Checkpoint Commit:**
    -   **Manual Review Policy:** Per project guidelines, a human must review the code changes for the phase before this commit is made.
    -   Stage all changes.
    -   Perform the commit with a clear and concise message (e.g., `conductor(checkpoint): Checkpoint end of Phase X`).

7.  **Attach Auditable Verification Report using Git Notes:**
    -   Draft a detailed verification report including test commands, manual verification steps, and the user's confirmation.
    -   Use `git notes` to attach the full report to the checkpoint commit.

8.  **Record Phase Checkpoint SHA:**
    -   Get the SHA of the checkpoint commit and append it to the Phase heading in `plan.md`.

9.  **Commit Plan Update:**
    -   Commit the `plan.md` update with a message like `conductor(plan): Mark phase '<PHASE NAME>' as complete`.

10. **Announce Completion:** Inform the user that the phase is complete and the checkpoint has been created.

## 5. Code Quality

-   **High Code Coverage:** Aim for greater than 75% code coverage for all modules. Code coverage metrics should be regularly monitored and integrated into the CI/CD pipeline.

## 6. Review and Committing Process

A human-in-the-loop is required for two critical stages:

-   **Task Review**: All completed tasks must undergo a human review process before they are considered done. This ensures adherence to quality standards and project principles.
-   **Git Commits**: The committing process will be managed by a human. Changes will be staged and reviewed, and an appropriate commit message crafted, before a commit is finalized.

## 7. Operational Guidelines

-   **Non-Interactive & CI-Aware:** Prefer non-interactive commands for all scripts and tools. For tools with watch modes (e.g., test runners, linters), use `CI=true` or equivalent flags to ensure single execution and prevent them from running indefinitely in continuous integration environments.
-   **Deployment Verification:** For mobile applications, all releases and major features must be verified on both a desktop emulator and a physical device (e.g., Android phone) before being considered complete.

## 8. Documentation

-   **The README is the Entrypoint:** The `README.md` file must be kept up-to-date at all times. This includes setup instructions, environment variables, and clear guidance on how to build, run, and test the application. Any task that introduces a change requiring documentation *must* include an update to the `README.md` file.
