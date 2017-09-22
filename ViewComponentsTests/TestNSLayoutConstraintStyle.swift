//
//  TestNSLayoutConstraintStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestNSLayoutConstraintStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<NSLayoutConstraint>] = [
        .isActive(true), AnyStyle<NSLayoutConstraint>.constant(20),
        .priority(200), .identifier("some"), .shouldBeArchived(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUISwitchStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UIView()
        let constraint = view.widthAnchor.constraint(equalToConstant: 10)
        
        constraint.isActive = false
        AnyStyle<NSLayoutConstraint>.isActive(true).sideEffect(on: constraint)
        XCTAssertEqual(constraint.isActive, true)
        
        constraint.constant = 30
        AnyStyle<NSLayoutConstraint>.constant(20).sideEffect(on: constraint)
        XCTAssertEqual(constraint.constant, 20)
        
        constraint.priority = UILayoutPriority(rawValue: 750)
        AnyStyle<NSLayoutConstraint>.priority(200).sideEffect(on: constraint)
        XCTAssertEqual(constraint.priority, UILayoutPriority.RawValue(200))
        
        constraint.identifier = nil
        AnyStyle<NSLayoutConstraint>.identifier("test").sideEffect(on: constraint)
        XCTAssertEqual(constraint.identifier, "test")
        
        constraint.isActive = false
        AnyStyle<NSLayoutConstraint>.shouldBeArchived(true).sideEffect(on: constraint)
        XCTAssertEqual(constraint.shouldBeArchived, true)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
