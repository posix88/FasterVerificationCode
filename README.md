# FasterVerificationCode
An high customizable and fast verification code view

[![Version](https://img.shields.io/cocoapods/v/FasterVerificationCode.svg?style=flat)](https://cocoapods.org/pods/FasterVerificationCode)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/posix88/FasterVerificationCode/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/FasterVerificationCode.svg?style=flat)](https://cocoapods.org/pods/FasterVerificationCode)


`FasterVerificationCode` is an open-source fully customizable `input view`  built to makes easier and faster the input of a verification code you provided via mail/phone. 

## Features
* Install it directly into your xib or storyboard.
* Support `Paste` action.
* Error handling.
* UI fully customizable through xib.

## System Requirements
iOS 10.0 or above

## Installation

#### As a CocoaPods Dependency

Add the following to your Podfile:
``` ruby
pod 'FasterVerificationCode'
```
#### Manual Installation

All of the necessary source and resource files for `FasterVerificationCode` are in `FasterVerificationCode/Classes`.

## Examples
Using `FasterVerificationCode` is very easy and straightforward. Simply create a new UIView into your ViewController and insert into the Custom class field `VerificationCodeView`.

Now customize the appearance through the inspector tab and add your constraints. 
Remember to add a width constraint and to declare it as placeholder (the view will resize at runtime following labels dimensions).

For a complete working example, check out the sample apps included in this repo.

### Basic Implementation

```swift
@IBOutlet weak var verificationCodeView: VerificationCodeView!

override func viewDidLoad()
{
	super.viewDidLoad()
	verificationCodeView.setLabelNumber(6) //modify this number based on your needs
	verificationCodeView.delegate = self
}
```
### VerificationCodeViewDelegate
This delegate handle the insertion of the verification code with this two method:
```swift
	func verificationCodeInserted(_ text: String, isComplete: Bool)
	@objc optional func verificationCodeChanged()
```
#### verificationCodeInserted

This method is mandatory and is called everytime the `textFieldShouldEndEditing` method of the textfield is called.
It gives you the current text and if the text was inserted totally.

You can check the inserted text and if the code is wrong you can show a visual error in this way

```swift
	if text == "123456"
	{
		.....
	} else
	{
		// CODE IS WRONG
		verificationCodeView.showError = true
	}
```

#### verificationCodeChanged
This method is optional and is called only when the user is deleting a character. It should be implemented only if you are interested in error handling and you want to reset the border color to the default color you inserted.

```swift
func verificationCodeChanged()
{
	verificationCodeView.showError = false
}
```

