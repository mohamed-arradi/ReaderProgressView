
# ReaderProgressView

![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS-yellowgreen?style=flat-square)


<a href="https://buymeacoffee.com/momolette" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
<br>
Elegant and Animated Progress Bar designed for tracking document reading progress in Swift.
It splits Progress Track with Remaining Track. This UI component integrates seamlessly with SwiftUI and UIKit, offering a customizable and visually appealing way to display a reading progress.

![ReaderProgressView](https://github.com/user-attachments/assets/a21ffaae-7b8d-478c-84a9-407b5b33c9f3)

## Installation

*SPM (Swift Package Manager)*

To install ReaderProgressView via Swift Package Manager, add the following to your Package.swift:
```swift
dependencies: [
    .package(url: "https://github.com/mohamed-arradi/ReaderProgressView.git", from: "0.0.2")
]
```

## Usage

SwiftUI Integration
To use ReaderProgressView in a SwiftUI view, you can initialize it with the desired progress, track color, and progress color.

```swift
import SwiftUI
import ReaderProgressView

struct ContentView: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack {
              ReaderProgressView(progress: $progress,
                               trackColor: .gray.opacity(0.3),
                               progressColor: .blue, 
                               spaceBetweenBars: 8.0)
            .frame(height: 10) // Set your own sizing
            // Add your own UI to increase / decrease progress value
            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.1, 1.0)
                }
            }
        }
    }
}
```
## Demo

### Light Mode

https://github.com/user-attachments/assets/7a3cb99f-4dde-42cd-9bd3-79797679c4ac

### Dark Mode

https://github.com/user-attachments/assets/70655568-4bc3-4dd7-b870-c45822885767

## Contribution

You are most welcome to create any PR to increase configuration capability or any other ideas are most welcome

<a href="https://buymeacoffee.com/momolette" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

