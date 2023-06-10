//
//  File.swift
//
//
//  Created by Dev on 5/8/23.
//

import Foundation

public enum ValidationType {
    case required
    case minValue(Int)
    case maxValue(Int)
    case characterSetIncluded(CharacterSet)
    case characterSetExcluded(CharacterSet)
    case isTrue
    case email
}
