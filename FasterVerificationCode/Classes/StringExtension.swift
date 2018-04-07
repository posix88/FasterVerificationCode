//
//  StringExtension.swift
//  FasterVerificationCode
//
//  Created by Musolino, Antonino Francesco on 07/04/2018.
//

import Foundation

extension String
{
	var isNumeric: Bool
	{
		guard self.count > 0 else { return false }
		let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		return Set(self).isSubset(of: nums)
	}
}
