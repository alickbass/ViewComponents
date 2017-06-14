//
//  TestUIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIControlStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIControl>] = [
        .isEnabled(true), .isSelected(true), .isHighlighted(true),
        .contentVerticalAlignment(.bottom), .contentHorizontalAlignment(.center)
    ]
    
    static var previousHashes: [Int : Any] { return TestUILabelStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UIControl()
        
        view.isEnabled = true
        AnyStyle<UIControl>.isEnabled(false).sideEffect(on: view)
        XCTAssertEqual(view.isEnabled, false)
        
        view.isSelected = true
        AnyStyle<UIControl>.isSelected(false).sideEffect(on: view)
        XCTAssertEqual(view.isSelected, false)
        
        view.isHighlighted = true
        AnyStyle<UIControl>.isHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, false)
        
        view.contentVerticalAlignment = .bottom
        AnyStyle<UIControl>.contentVerticalAlignment(.top).sideEffect(on: view)
        XCTAssertEqual(view.contentVerticalAlignment, .top)
        
        view.contentHorizontalAlignment = .left
        AnyStyle<UIControl>.contentHorizontalAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.contentHorizontalAlignment, .center)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
