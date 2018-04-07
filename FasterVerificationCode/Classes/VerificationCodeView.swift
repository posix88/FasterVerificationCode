//
//  VerificationCode.swift
//
//  Created by Musolino, Antonino Francesco on 02/03/2018.
//

@objc public protocol VerificationCodeViewDelegate: class
{
	func verificationCodeInserted(_ text: String, isComplete: Bool)
	@objc optional func verificationCodeChanged()
}

import UIKit

public class VerificationCodeView: UIView
{

    @IBOutlet private weak var labelContainer: UIStackView!
    @IBOutlet private weak var hiddenTextField: VerificationCodeTextField!

	/// True if VerificationCodeLabels have to show bottom border
    @IBInspectable
    open var labelHasBorder: Bool = true

	/// The VerificationCodeLabel border heigth
	@IBInspectable
	open var borderHeigth: CGFloat = 1

	/// The VerificationCodeLabel border color
	@IBInspectable
	open var labelBorderColor: UIColor = .black

	/// The VerificationCodeLabel border color in case of error
	@IBInspectable
	open var labelErrorColor: UIColor = .red

	/// The VerificationCodeLabel text color
	@IBInspectable
	open var labelTextColor: UIColor = .black

	/// The VerificationCodeLabel tint color
    @IBInspectable
    open var labelTintColor: UIColor = .black

	/// The VerificationCodeLabel background color
    @IBInspectable
    open var labelBackgroundColor: UIColor = .white

    /// The VerificationCodeLabel width
    @IBInspectable
    open var labelWidth: CGFloat = 0

	/// The space between labels
	@IBInspectable
	open var labelSpacing: CGFloat = 0

	/// True if the code has to be numeric
    @IBInspectable
    open var isNumeric: Bool = true

	/// The VerificationCodeLabel font
    open var labelFont: UIFont? = UIFont.systemFont(ofSize: 20)

	/// True if the VerificationCodeLabels have to show the error
	open var showError: Bool = false
	{
		didSet
		{
			let borderColor: UIColor = showError ? labelErrorColor : labelBorderColor
			for label in labels
			{
				label.borderColor = borderColor
			}
		}
	}

	/// If true, the textfield become first responder during initialization
	open var focusOnLoad: Bool = false

	public weak var delegate: VerificationCodeViewDelegate?

    /// Labels inserted into the StackView
    fileprivate var labels: [VerificationCodeLabel] = []

    /// The index of the current selected label
    fileprivate var currentLabel: Int = 0

    /// The number of label
    fileprivate var numberOfLabel: Int = 0

    private var view: UIView!

	/// The tap gesture that open the keyboard
    private var tapGesture: UITapGestureRecognizer!

	/// The long press gesture that trigger the paste action
    private var longPressGesture: UILongPressGestureRecognizer!

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

	required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        guard
            let xib = Bundle(for: VerificationCodeView.self).loadNibNamed("VerificationCodeView", owner: self, options: nil),
            let views = xib as? [UIView] else
        {
            return
        }

        if views.count > 0
        {
            view = views[0]
            view.frame = bounds
            view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            view.backgroundColor = .clear
            self.addSubview(view)
			self.backgroundColor = .clear
        }

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(openKeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showPasteMenu))
        longPressGesture.minimumPressDuration = 1
        self.addGestureRecognizer(longPressGesture)
        hiddenTextField.keyboardType = isNumeric ? .numberPad : .default
    }

	override public func awakeFromNib()
    {
        super.awakeFromNib()
        hiddenTextField.delegate = self
    }


    /// The initialization method that size the view and add the labels
    ///
    /// - Parameter numberOfLabel: the number of label to be shown
    public func setLabelNumber(_ numberOfLabel: Int)
    {
        guard numberOfLabel > 0
        else
        {
            return
        }
		labelContainer.spacing = labelSpacing > 0 ? labelSpacing : 10
        self.numberOfLabel = numberOfLabel
        calculateViewWidth()
        addLabelsToStackView()
    }

    private func addLabelsToStackView()
    {
        for _ in 1...numberOfLabel
        {
			let label = VerificationCodeLabel(CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height), isBordered: labelHasBorder, borderColor: labelBorderColor, borderHeight: borderHeigth, tintColor: labelTintColor, backgroundColor: labelBackgroundColor)
            label.font = labelFont
			label.textColor = labelTextColor
            labelContainer.addArrangedSubview(label)
            labels.append(label)
        }
		if focusOnLoad
		{
			openKeyboard()
		}
    }

    private func calculateViewWidth()
    {
        let numberOfSpace: CGFloat = CGFloat(numberOfLabel - 1)
        let spaceOfLabels: CGFloat = labelWidth * CGFloat(numberOfLabel)
        let spaceBetweenLabels: CGFloat = numberOfSpace * labelSpacing
        let newWidth: CGFloat = CGFloat(spaceBetweenLabels + spaceOfLabels)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: newWidth)
        self.addConstraint(widthConstraint)
    }

    @objc private func openKeyboard()
    {
        hiddenTextField.becomeFirstResponder()
        if currentLabel != labels.count
        {
            labels[currentLabel].startCarrierAnimation()
        }
    }

    @objc private func showPasteMenu()
    {
        hiddenTextField.becomeFirstResponder()

        let menu = UIMenuController.shared

        if !menu.isMenuVisible
        {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
}

extension VerificationCodeView: UITextFieldDelegate
{
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

	public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
	{
		stopCurrentCarrierAnimation()
		guard let text = textField.text
		else
		{
			delegate?.verificationCodeInserted("", isComplete: false)
			return true
		}

		let codeFullyInserted: Bool = text.count == numberOfLabel ? true : false

		delegate?.verificationCodeInserted(text, isComplete: codeFullyInserted)

		return true
	}

	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = textField.text
        else
		{
			return true
		}

		guard insertedTextIsValid(string) || string.count == 0
		else
		{
			return false
		}

		// this is possible only if i've just pasted some text
		if string.count > 1
        {
			return verificationCodeTextField(textField, handleCopiedText: string)
        }
        let newLength = text.count + string.count - range.length

		// I'm adding characters into the textfield
        if newLength <= numberOfLabel && string.count > 0
        {
            stopCurrentCarrierAnimation()
            labels[currentLabel].text = string
            currentLabel += 1
            startCurrentCarrierAnimation()
        }
		// I'm deleting characters from the textfield
		else if string.count == 0
        {
			delegate?.verificationCodeChanged?()
            if range.length > 1
            {
                for label in labels
                {
                    label.text = ""
                    currentLabel = 0
                }
            } else if range.length == 1
            {
                stopCurrentCarrierAnimation()
                currentLabel -= 1
                labels[currentLabel].text = ""
                startCurrentCarrierAnimation()
            } else if range.length == 0
            {
                return true
            }
        }

		if newLength == numberOfLabel
		{
			// Calling resignFirstResponder doesn't update textfield text
			// I've to add manually the last char
			textField.text?.append(string)
			textField.resignFirstResponder()
		}

        return newLength <= numberOfLabel
    }

    private func stopCurrentCarrierAnimation()
    {
        if currentLabel != labels.count
        {
            labels[currentLabel].stopCarrierAnimation()
        }
    }

    private func startCurrentCarrierAnimation()
    {
        if currentLabel != labels.count
        {
            labels[currentLabel].startCarrierAnimation()
        }
    }

	private func verificationCodeTextField(_ textField: UITextField, handleCopiedText string: String) -> Bool
	{
		stopCurrentCarrierAnimation()
		currentLabel = 0
		for label in labels
		{
			if let index = string.index(string.startIndex, offsetBy: currentLabel, limitedBy: string.endIndex)
			{
				label.text = String(string[index])
				currentLabel += 1
			} else
			{
				return false
			}
		}
		textField.text = ""
		return true
	}

	private func insertedTextIsValid(_ text: String) -> Bool
	{
		if isNumeric && !text.isNumeric
		{
			return false
		}
		return true
	}
}
