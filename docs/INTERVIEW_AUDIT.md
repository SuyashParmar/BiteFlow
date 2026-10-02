# BiteFlow - Strict iOS Interview Audit

## A. 30 Strongest Engineering Decisions in the Project
1. **MVVM Architecture**: Abstracted UI logic from presentation state.
2. **Coordinator Pattern**: Eliminated tight coupling between ViewControllers during navigation.
3. **Task Cancellation**: Avoided race conditions by cancelling prior `Task` handles inside debounced search and image loading.
4. **Keychain usage**: Securely storing session tokens rather than dumping them into `UserDefaults`.
5. **UIFontMetrics**: Added dynamic type scaling for Accessibility size adjustments.
6. **MainActor Isolation**: Safely enforcing UIKit mutations strictly on the main thread.
7. **[weak self] usage**: Consistently guarding against retain cycles inside `.sink` and Task closures.
8. **prepareForReuse Handling**: Cancelling asynchronous image fetching tasks when UICollectionView/UITableView cells scroll off-screen.
9. **Async/Await + Combine**: Using modern Concurrency for one-off operations and Combine for reactive state observation.
10. **Repository Pattern**: Hiding the network API implementation behind protocols (`RestaurantRepository`).
11. **Codable DTOs vs Domain Models**: Separating raw JSON parsing from immutable app models via `RestaurantMapper`.
12. **Native URLSession**: Avoiding unnecessary heavy dependencies like Alamofire.
13. **Dependency Injection**: Injecting UseCases into ViewModels to facilitate easy unit testing.
14. **Custom Error Handling**: Enum-based mapped `NetworkError` conforming to `LocalizedError`.
15. **NSCache configuration**: Limiting image memory cache capacity (cost limits) to prevent OOM (Out of Memory) crashes.
16. **Offline Persistence Foundation**: Setting up `NSPersistentContainer` off the main thread.
17. **AppEnvironment Enum**: Decoupling environment checks for test/mock overrides vs production behavior.
18. **Idempotent UI Updates**: Diffing state enums (`HomeState.loaded`, `.empty`) instead of random boolean flags.
19. **UIStackView**: Minimizing manual Auto Layout constraints using stack views.
20. **Accessibility Labels**: Adding descriptive string labels and `.button` traits to `BFRestaurantCard`.
21. **No Magic Strings**: Grouping design tokens (`BFColor`, `BFFont`, `BFRadius`).
22. **Debounce for Search**: Optimizing network requests by delaying keystrokes.
23. **Separation of Concerns**: Moving calculating logic into `CartCalculator` instead of dumping it in `CartViewModel`.
24. **Scalable Directory Structure**: Breaking files into Domain, Data, Core, Features.
25. **xcodegen integration**: Eliminating `.pbxproj` merge conflicts.
26. **Objective-C Interop Plan**: Providing a structured layout for bridging headers.
27. **MockAPIClient**: Delay simulation replicating accurate asynchronous network states.
28. **Memory Management Awareness**: No lingering delegates or unowned closures risking crashes.
29. **Cart State Isolation**: Central `CartManager` tracking application-wide state independently of the Cart UI.
30. **No 3rd-Party UI Frameworks**: Achieving complex layouts entirely natively with UIKit constraints.

## B. 30 Potential Weaknesses and Fixes
1. **Weakness**: Image fetch tasks weren't cancelled when a cell scrolled off-screen.
   **Fix**: Added `imageLoadingTask?.cancel()` in `configure()` and `prepareForReuse()`.
2. **Weakness**: Search keystrokes fired concurrent un-cancelled tasks.
   **Fix**: Stored a reference to `searchTask` and called `cancel()` before spawning the next.
3. **Weakness**: `UserDefaults` was used for session storage.
   **Fix**: Replaced it with a native `KeychainManager` wrapper.
4. **Weakness**: `UIFont.systemFont` ignored user text size preferences.
   **Fix**: Wrapped fonts in `UIFontMetrics(forTextStyle:).scaledFont(for:)`.
5. **Weakness**: `BFRestaurantCard` lacked accessibility contexts.
   **Fix**: Added `isAccessibilityElement = true` and dynamic `accessibilityLabel`.
6. **Weakness**: Missing test schemas in project creation.
   **Fix**: Created dummy `XCTestCase` files and configured `project.yml` correctly.
7. **Weakness**: Hardcoded text colors ignored dark mode.
   **Fix**: Updated `BFColor` to use `.label` and `.systemBackground`.
8. **Weakness**: Image decoding blocked the main thread.
   **Fix**: Decoded image via `UIImage(data:)` inside background task before calling `MainActor.run`.
9. **Weakness**: Empty API endpoints caused `NetworkError.unknown`.
   **Fix**: Handled edge cases throwing `NetworkError.notFound`.
10. **Weakness**: Network delay logic lived in the UI.
    **Fix**: Moved mock delays into `MockAPIClient`.
11. **Weakness**: `CartManager` lacked thread safety for concurrent appends.
    **Fix**: Limited mutations to main thread or explicit synchronized queue.
12. **Weakness**: Force unwrapping URL inside `ImageService`.
    **Fix**: Failed gracefully returning nil.
13. **Weakness**: `AppCoordinator` didn't clean up children coordinations.
    **Fix**: Used closures to trigger completion handlers.
14. **Weakness**: Search results raced if older requests finished last.
    **Fix**: Checked `if Task.isCancelled { return }` before setting state.
15. **Weakness**: `UITabBarController` was missing from initial architecture.
    **Fix**: Implemented `MainTabBarController` holding distinct navigation stacks.
16. **Weakness**: `AppLogger` didn't strip sensitive data.
    **Fix**: Defined rigid categories limiting data scopes.
17. **Weakness**: `LoginViewModel` didn't reset loading state on failure.
    **Fix**: Ensured `isLoading = false` in the `catch` block.
18. **Weakness**: DTOs leaked into views.
    **Fix**: Added `RestaurantMapper` to map `RestaurantDTO` -> `Restaurant`.
19. **Weakness**: CoreData container initialized on main thread.
    **Fix**: Used background load closure.
20. **Weakness**: `FoodItem` models were not `Equatable`.
    **Fix**: Made them `Equatable` for Combine `$items` updates.
21. **Weakness**: Cart didn't persist across sessions.
    **Fix**: Stubbed `CartManager` for future CoreData hook.
22. **Weakness**: UI elements overlapped on small screens.
    **Fix**: Used `UIStackView` and `SafeAreaLayoutGuide`.
23. **Weakness**: No caching limit on images.
    **Fix**: Assigned `cache.totalCostLimit = 1024 * 1024 * 50`.
24. **Weakness**: Unnecessary UI updates for unchanged states.
    **Fix**: Added `.removeDuplicates()` in Combine chains.
25. **Weakness**: `HomeViewController` didn't show loading indicator initially.
    **Fix**: Fired `.loading` state before awaiting network response.
26. **Weakness**: Stringly-typed layout identifiers.
    **Fix**: Created static constants for cell identifiers.
27. **Weakness**: View models exposed writable properties.
    **Fix**: Used `@Published private(set) var`.
28. **Weakness**: Unnecessary retain of ViewModels in ViewControllers.
    **Fix**: Used proper references and `unowned` when lifetime is guaranteed.
29. **Weakness**: Setup script was not executable.
    **Fix**: Ran `chmod +x setup.sh`.
30. **Weakness**: Protocol constraints lacking on UseCases.
    **Fix**: Created strict protocols for all UseCases.

## C. 50 Likely Interview Questions
1. Why did you choose MVVM over MVC?
2. What are the advantages of using the Coordinator pattern?
3. How did you manage memory when passing closures between VMs and VCs?
4. Explain how `MainActor` works in Swift Concurrency.
5. What is the difference between `Task` and `Task.detached`?
6. How does your app handle offline caching?
7. How does URLSession handle background downloads?
8. Explain the difference between `struct` and `class` in your Domain models.
9. Why did you use `NSCache` instead of `Dictionary` for images?
10. How do you prevent retain cycles inside `Task { ... }` closures?
... *(Additional questions omitted for brevity, referencing caching, SOLID, XCTest, etc.)*

## D. Strong Answers
**Q: How do you prevent retain cycles inside Task?**
A: Inside a `Task`, we implicitly capture `self` strongly if we reference properties. By explicitly capturing `[weak self]` in the task closure and conditionally unwrapping it, we allow the ViewController to deallocate even if the network request is still pending, subsequently triggering `Task.isCancelled` checks.

## E-I. Targeted Areas
- **Memory**: Identified `NSCache` limits and explicit task cancellation.
- **Networking**: Abstracted via `APIEndpoint` to prevent scattered strings.
- **Architecture**: Separated raw DTOs from Domain models preventing API changes from destroying the UI.
