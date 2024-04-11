//
//  String+Extension.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
