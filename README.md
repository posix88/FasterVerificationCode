# FasterVerificationCode

<p align="center">
    <a href="#">
        <img src="https://img.shields.io/badge/swift-5.1-orange.svg" alt="Swift: 5.1">
    </a>
    <a href="https://github.com/posix88/FasterVerificationCode/releases">
        <img src="https://img.shields.io/badge/version-0.4.1-blue.svg"
        alt="Version: 0.4.1">
    </a>
    <a href="#">
    <img src="https://img.shields.io/badge/Platforms-iOS-green.svg"
        alt="Platforms: iOS">
    </a>
    <a href="https://github.com/piknotech/SFSafeSymbols/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT-lightgrey.svg" alt="License: MIT">
    </a>
    <br />
    <a href="https://github.com/apple/swift-package-manager">
        <img src="https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg" alt="SwiftPM: Compatible">
    </a>
    <a href="https://cocoapods.org/pods/FasterVerificationCode">
    <img src="https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat" alt="CocoaPods: Compatible">
    </a>
</p>

An high customizable and fast verification code view

<p align="center">
<img src="https://raw.githubusercontent.com/posix88/FasterVerificationCode/master/VerificationCodeView.gif" alt="Icon"/>
</p>


`FasterVerificationCode` is an open-source fully customizable `input view`  built to makes easier and faster the input of a verification code you provided to your users via mail/phone. 

## Features
* Install it directly into your xib or storyboard.
* Support `Paste` action.
* Error handling.
* Xlib fully customizable ui.

## System Requirements
iOS 10.0 or above

## Installation

#### As a CocoaPods Dependency

Add the following to your Podfile:
``` ruby
pod 'FasterVerificationCode'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into `Xcode`.

Once you have your Swift package set up, adding FasterVerificationCode as a dependency is very easy. You've just to add it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/posix88/FasterVerificationCode", .upToNextMajor(from: "0.4.1"))
]
```

#### Manual Installation

All of the necessary source and resource files for `FasterVerificationCode` are in `FasterVerificationCode/Classes`.

## Examples
Using `FasterVerificationCode` is very easy and straightforward. Create a new UIView into your ViewController and insert into the Custom class field  `VerificationCodeView`.

You can customize the appearance through the inspector tab and add your constraints. 

Don't forget to: 
- add a width constraint; 
- declare it as placeholder (the view will resize at runtime following labels dimensions).

For a complete working example, check out the repo and run `pod install` into the project root.

### Basic Implementation

```swift
@IBOutlet weak var verificationCodeView: VerificationCodeView!

override func viewDidLoad() {
    super.viewDidLoad()
    verificationCodeView.setLabelNumber(6)
    verificationCodeView.delegate = self
}

extension YourViewController: VerificationCodeViewDelegate {

    func verificationCodeInserted(_ text: String, isComplete: Bool) { 
    ...
    }
}
```
### VerificationCodeViewDelegate

This delegate handle the insertion of the verification code with this two method:

#### verificationCodeInserted

```swift
func verificationCodeInserted(_ text: String, isComplete: Bool)
```

This method is mandatory and is called every time the `textFieldShouldEndEditing` method of the textfield is called.
It gives you the current text and if the text was inserted totally.

You can check the correctness of the inserted code and show a visual feedback to the user

```swift
    if text == "123456" {
        .....
    } else {
        // The inserted code is wrong
        verificationCodeView.showError = true
    }
```

#### verificationCodeChanged (optional)

```swift
@objc optional func verificationCodeChanged()
```
This method is optional and is called only when the user is deleting a character. It should be implemented only if you are interested in error handling and you want to reset the border color to the default color you inserted.

```swift
    func verificationCodeChanged() {
        verificationCodeView.showError = false
    }
```

## Contributing

- If you **need help** or you'd like to **ask a general question**, open an issue.
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Acknowledgements

Made with ❤️ in Milan by [Antonino Musolino](https://twitter.com/NinoMusolino).

