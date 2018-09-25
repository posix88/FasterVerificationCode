//
//  VerificationCodeLabel.swift
//
//  Created by Musolino, Antonino Francesco on 02/03/2018.
//

import UIKit

public class VerificationCodeLabel: UILabel
{
    private var isBordered: Bool = true
	
    private var carrierView: UIView!

	private var bottomBorder: CALayer?
	private var borderHeight: CGFloat = 1

	open var borderColor: UIColor = .black
	{
		didSet
		{
			if isBordered
			{
				addLine(CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1))
			}
		}
	}

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

	required public init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

	public convenience init(_ frame: CGRect, isBordered: Bool, borderColor: UIColor, borderHeight: CGFloat, tintColor: UIColor, backgroundColor: UIColor = .white)
    {
        self.init(frame: frame)
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.textAlignment = .center
        self.isBordered = isBordered
		self.borderHeight = borderHeight
		self.borderColor = borderColor
        addCarrierView()
    }

    private func addCarrierView()
    {
        carrierView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: self.font.pointSize))
        carrierView.center = self.center
        carrierView.alpha = 0
        carrierView.backgroundColor = self.tintColor
        self.addSubview(carrierView)
        self.bringSubviewToFront(carrierView)
    }

    private func addLine(_ line: CGRect)
    {
		bottomBorder?.removeFromSuperlayer()
        bottomBorder = CALayer()
        bottomBorder!.frame = line
        bottomBorder!.backgroundColor = borderColor.cgColor
        layer.addSublayer(bottomBorder!)
    }

	override public func layoutSubviews()
    {
        super.layoutSubviews()
        if isBordered
        {
            addLine(CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: borderHeight))
        }
    }

    func startCarrierAnimation()
    {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations:
        {
            self.carrierView.alpha = 1
        }, completion: nil)

    }

    func stopCarrierAnimation()
    {
        self.carrierView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.05, delay: 0, options: [.curveEaseOut], animations:
        {
            self.carrierView.alpha = 0
        }, completion: nil)
    }
}

public class VerificationCodeTextField: UITextField
{
	override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        if action == #selector(UIResponderStandardEditActions.paste(_:))
        {
            return true
        }
        return false
    }
}
