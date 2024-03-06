//
//  Extension.swift
//  machineAssignment
//
//  Created by Sayan Das on 05/03/24.
//

import Foundation
import UIKit

@IBDesignable public class RoundedView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

//MARK: main storyboard
let storyboard = UIStoryboard(name: "Main", bundle: nil)


//MARK: lorem ipsum generator
func generateLoremIpsum(from length: Int) -> [String] {
    let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    // Split the big paragraph into an array of sentences
        var sentences = loremIpsum.components(separatedBy: ". ")
        // Shuffle the array of sentences randomly
        sentences.shuffle()
        // Extend or repeat the array to ensure it has at least size elements
        while sentences.count < length {
            sentences += sentences
        }

        // Trim the array to exactly size elements
        sentences = Array(sentences.prefix(length))

        return sentences
    
}


//MARK: convert string to Int, Float & Bool
extension String {
    //Converts String to Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    // MARK: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    //Converts String to Bool
    public func toBool() -> Bool? {
        return (self as NSString).boolValue
    }
}

