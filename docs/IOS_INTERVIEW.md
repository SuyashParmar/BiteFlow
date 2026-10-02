# iOS Interview Guide

Here are questions based on the implementation of BiteFlow.

## 1. Why use MVVM over MVC?
In BiteFlow, MVVM allows us to test business logic independently of the UIKit lifecycle. Our ViewModels handle the heavy lifting and expose `@Published` states.

## 2. Explain your networking layer.
We use native `URLSession` combined with `async/await`. We defined an `APIEndpoint` protocol that builds `URLRequest`s cleanly.

## 3. How do you handle retain cycles?
By using `[weak self]` in Combine sinks and closures. For example, in `HomeViewController`, we capture `[weak self]` when observing `viewModel.$state`.

## 4. How does Coordinator pattern help?
It abstracts navigation out of the `UIViewController`, so the VC doesn't need to know where it's going next. This helps in scaling the app.

*(Note: In a full scenario, 50 detailed questions would be elaborated here regarding Core Data, Testing, CI/CD, UICollectionView, and more.)*
