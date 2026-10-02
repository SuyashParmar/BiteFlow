# Architecture Decisions

## MVVM vs MVC
We chose MVVM (Model-View-ViewModel) over Apple's traditional MVC. MVC often leads to Massive View Controllers where UI, networking, and business logic are tightly coupled. By using ViewModels, we isolate business logic and presentation state, making the code much easier to unit test. ViewControllers act only as view managers and event routers.

## Coordinator Pattern
Rather than having ViewControllers push or present other ViewControllers directly, navigation logic is extracted into Coordinators. This keeps ViewControllers decoupled and highly reusable. 

## Dependency Injection
We use constructor injection for our Repositories and Use Cases. This allows us to pass mock implementations (like `MockAPIClient`) during testing or demo mode.
