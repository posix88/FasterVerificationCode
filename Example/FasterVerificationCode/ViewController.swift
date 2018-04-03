//
//  ViewController.swift
//  FasterVerificationCode
//
//  Created by Posix88 on 03/23/2018.
//  Copyright (c) 2018 Posix88. All rights reserved.
//

import UIKit
import FasterVerificationCode

class ViewController: UIViewController
{
	@IBOutlet weak var verificationCodeView: VerificationCodeView!

    override func viewDidLoad()
	{
        super.viewDidLoad()
		verificationCodeView.setLabelNumber(6)
		verificationCodeView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: VerificationCodeViewDelegate
{
	func verificationCodeInserted(_ text: String, isComplete: Bool)
	{
		if text == "123456"
		{
			let alertVC = UIAlertController(title: "FasterVerificationCode", message: "Code Inserted Succesfully", preferredStyle: .alert)
			let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
			alertVC.addAction(action)
			self.present(alertVC, animated: true, completion: nil)
		} else
		{
			// CODE IS WRONG
			verificationCodeView.showError = true
		}
	}

	func verificationCodeChanged()
	{
		verificationCodeView.showError = false
	}
}
