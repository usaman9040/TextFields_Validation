import Foundation
import SwiftUI

/// - Tag: Valuable
public protocol Valuable {
    associatedtype ValueType
    var value: ValueType { get }
    mutating func update(_ newValue: ValueType) throws
}

public struct FormField<ValueType>: Valuable {

    public var title: String
    public var value: ValueType
    public var validations: [ValidationType]
    
    /// Constructor
    /// - Parameters:
    ///   - title: name/placeholder of the field
    ///   - value: value in the field
    ///   - validations: rules required for the field
    public init(title: String, value: ValueType, validations: [ValidationType] = []) {
        self.title = title
        self.value = value
        self.validations = validations
    }
    
    /// Validates all rules on the field value, then update it
    /// - Parameter newValue: field value to validate.
    public mutating func update(_ newValue: ValueType) throws {
        switch newValue {
        case let newValue as String:
            try validateString(value: newValue)
        case let newValue as Int:
            try validateInt(value: newValue)
        case let newValue as Bool:
            try validateBool(value: newValue)
        default:
            throw ValidationError.unsupportedFieldType(title)
        }

        self.value = newValue
    }
    
    /// Validate rules on the string value.
    /// - Parameter value: String value to validate.
    func validateString(value: String) throws {
        for validation in validations {
            switch validation {
            case .required:
                if value.isEmpty {
                    throw ValidationError.required(title)
                }
            case .minValue(let intValue):
                if value.count < intValue {
                    throw ValidationError.minLength(title, intValue)
                }
            case .maxValue(let intValue):
                if value.count > intValue {
                    throw ValidationError.maxLength(title, intValue)
                }
            case .characterSetIncluded(let charSet):
                if value.rangeOfCharacter(from: charSet.inverted) == nil {
                    throw ValidationError.characterSetIncluded(title, charSet)
                }
            case .characterSetExcluded(let charSet):
                if value.rangeOfCharacter(from: charSet) == nil {
                    throw ValidationError.characterSetExcluded(title, charSet)
                }
            case .email:
                let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                let searchResult = predicate.evaluate(with: value)
                if !searchResult {
                    throw ValidationError.email(title)
                }
            default:
                break
            }
        }
    }
    
    /// Validates rules on int value
    /// - Parameter value: int value to validate
    func validateInt(value: Int) throws {
        for validation in validations {
            switch validation {
            case .minValue(let intValue):
                if value < intValue {
                    throw ValidationError.minLength(title, intValue)
                }
            case .maxValue(let intValue):
                if value > intValue {
                    throw ValidationError.maxLength(title, intValue)
                }
            default:
                break
            }
        }
    }
    
    /// Validate rules on bool value
    /// - Parameter value: bool value to validate.
    func validateBool(value: Bool) throws {
        for validation in validations {
            switch validation {
            case .isTrue:
                if !value {
                    throw ValidationError.isTrue(title)
                }
            default:
                break
            }
        }
    }
    
}
