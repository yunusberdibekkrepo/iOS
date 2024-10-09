//
//  CurrencyFormatterTests.swift
//  BankeyTests
//
//  Created by Yunus Emre Berdibek on 9.10.2024.
//

@testable import Bankey
import UIKit
import XCTest

final class CurrencyFormatterTests: XCTestCase {
    // Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
    // Naming structure: test_[struct or class]_[variable or function]_[expected value]

    // Testing structure: Given, When, Then

    var formatter: CurrencyFormatter!

    override func setUpWithError() throws {
        formatter = CurrencyFormatter()
    }

    func test_CurrencyFormatter_BreakIntoDollarsAndCents_IsEqual() throws {
        // Given
        let value: Decimal = 929466.23

        // When
        let result = formatter.breakIntoDollarsAndCents(value)

        // Then
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
}
