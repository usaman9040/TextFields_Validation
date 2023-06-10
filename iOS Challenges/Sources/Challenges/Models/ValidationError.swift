//
//  File.swift
//
//
//  Created by Dev on 5/8/23.
//

import Foundation

enum ValidationError: Error, LocalizedError, Equatable {
    case unsupportedFieldType(String)
    case required(String)
    case minLength(String, Int)
    case maxLength(String, Int)
    case characterSetIncluded(String, CharacterSet)
    case characterSetExcluded(String, CharacterSet)
    case isTrue(String)
    case email(String)
    
    var errorDescription: String? {
        switch self {
        case .unsupportedFieldType(let fieldName):
            return "\(fieldName) Unsupported field type"
        case .required(let fieldName):
            return "\(fieldName) is required"
        case .minLength(let filedName, let intValue):
            return "\(filedName) require min length of \(intValue)"
        case .maxLength(let filedName, let intValue):
            return "\(filedName) require max length of \(intValue)"
        case .characterSetIncluded(let filedName, let charSet):
            return "\(filedName) should include \(charSet.description)"
        case .characterSetExcluded(let filedName, let charSet):
            return "\(filedName) should not include \(charSet.description)"
        case .isTrue(let filedName):
            return "\(filedName) should be True"
        case .email(let filedName):
            return "\(filedName) email format is not valid"
        }
    }
}
