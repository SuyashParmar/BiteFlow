# Debugging Guide

## Network Timeout
**Symptoms:** Infinite loaders or "The request timed out."
**Diagnosis:** Check `AppEnvironment`. If in demo mode, ensure `MockAPIClient` delays aren't too long. If production, check `URLSession` timeout configuration.

## Retain Cycles
**Symptoms:** ViewControllers don't deallocate when dismissed.
**Diagnosis:** Add `deinit { print("Deallocated: \(self)") }`. Search for strong `self` references inside closures, specifically in Combine `.sink` or networking callbacks.

## UI Updating on Background Thread
**Symptoms:** Purple warnings in Xcode, crashes, or delayed UI updates.
**Diagnosis:** Ensure all UI mutations happen on `@MainActor`. Check `Task { @MainActor in }` usage.
