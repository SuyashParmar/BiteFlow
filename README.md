# BiteFlow - Smart Food Discovery & Delivery

"Discover food. Order faster. Track everything."

## Overview
BiteFlow is a premium, modern food discovery and delivery application for iOS. It is built natively using Swift and UIKit, adopting the MVVM architecture and Coordinator pattern.

## Architecture
The application is structured into the following layers:
- **App**: Bootstrapping, Coordinators, and environment configurations.
- **Core**: Networking, logging, constants, and utilities.
- **Domain**: Business models, Use Cases, and Repositories protocols.
- **Data**: API clients, Mappers, Remote/Local implementations.
- **Features**: Distinct modules (Home, Search, Cart, Checkout) with ViewModels.
- **DesignSystem**: Reusable UI components.

## Tech Stack
- **Language**: Swift 5+
- **UI Framework**: UIKit
- **Architecture**: MVVM + Coordinator
- **Persistence**: Core Data
- **Concurrency**: async/await, Task, MainActor
- **Networking**: URLSession, Codable

## Offline Strategy
The application caches data locally using Core Data. When offline, it serves cached records and warns the user with an offline banner.

## AI Assistant
Includes a demo AI recommendation service to filter foods based on dietary preferences.

## Running Instructions
1. Clone the repository.
2. Run `xcodegen generate` to generate the `.xcodeproj` file.
3. Open `BiteFlow.xcodeproj`.
4. Build and run the `BiteFlow` scheme on an iOS 16+ Simulator.

## Demo Credentials
- **Email**: demo@biteflow.app
- **Password**: password123
