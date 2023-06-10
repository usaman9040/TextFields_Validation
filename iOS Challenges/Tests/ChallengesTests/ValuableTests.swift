import XCTest
@testable import Challenges

final class ValuableTests: XCTestCase {
    var stringField = FormField<String>(title: "Name", value: "", validations: [.required, .minValue(2), .maxValue(10)])
    var stringEmailField = FormField<String>(title: "Email", value: "", validations: [.required, .email])
    var intField = FormField<Int>(title: "House Number", value: 0, validations: [.minValue(2), .maxValue(10)])
    var boolField = FormField<Bool>(title: "Term and condition", value: false, validations: [.isTrue])

}

// MARK: - For String

extension ValuableTests {
    
    func testStringRequired() {
        XCTAssertNoThrow(try stringField.update("TrackVia"))

        XCTAssertThrowsError(try stringField.update("")) { error in
            XCTAssertEqual(error as! ValidationError, .required(stringField.title))
        }
    }
    
    func testStringRange() {
        XCTAssertNoThrow(try stringField.update("TrackVia"))

        XCTAssertThrowsError(try stringField.update("a")) { error in
            XCTAssertEqual(error as! ValidationError, .minLength(stringField.title, 2))
        }
        
        XCTAssertThrowsError(try stringField.update("TrackVia TrackVia")) { error in
            XCTAssertEqual(error as! ValidationError, .maxLength(stringField.title, 10))
        }
    }
}

// MARK: For Email

extension ValuableTests {
    func testStringEmailRange() {
        XCTAssertNoThrow(try stringEmailField.update("trackvia@test.com"))

        XCTAssertThrowsError(try stringEmailField.update("track")) { error in
            XCTAssertEqual(error as! ValidationError, .email(stringEmailField.title))
        }
        
        XCTAssertThrowsError(try stringEmailField.update("")) { error in
            XCTAssertEqual(error as! ValidationError, .required(stringEmailField.title))
        }
    }
}

// MARK: - For Int

extension ValuableTests {
    
    func testIntRange() {
        XCTAssertNoThrow(try intField.update(5))

        XCTAssertThrowsError(try intField.update(1)) { error in
            XCTAssertEqual(error as! ValidationError, .minLength(intField.title, 2))
        }
        
        XCTAssertThrowsError(try intField.update(11)) { error in
            XCTAssertEqual(error as! ValidationError, .maxLength(intField.title, 10))
        }
    }
}

// MARK: - For Bool

extension ValuableTests {
    
    func testBool() {
        XCTAssertNoThrow(try boolField.update(true))

        XCTAssertThrowsError(try boolField.update(false)) { error in
            XCTAssertEqual(error as! ValidationError, .isTrue(boolField.title))
        }
    }
}
