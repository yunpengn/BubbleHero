//
//  String+Pattern.swift
//  BubbleHero
//
//  Created by Yunpeng Niu on 01/03/18.
//  Copyright © 2018 Yunpeng Niu. All rights reserved.
//

/**
 Provides some utility methods to support pattern matching for a `String`
 using regular expressions.

 - Author: Niu Yunpeng @ CS3217
 - Date: Feb 2018
 */
extension String {
    /// Checks whether this string matches a given regular expression.
    /// - Parameter regex: The pattern expressed in a regular expression.
    /// - Returns: True if it matches; false otherwise.
    func match(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
