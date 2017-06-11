//
//  TestUIControlStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIControlStyle: XCTestCase {
    
    static let allStyles: [UIControlStyle<UIControl>] = [
        .isEnabled(true), .isSelected(true), .isHighlighted(true),
        .contentVerticalAlignment(.bottom), .contentHorizontalAlignment(.center)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUILabelStyle.accumulatedHashes + TestUIControlStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(UIControlStyle.isEnabled(true), .isEnabled(true))
        XCTAssertNotEqual(UIControlStyle.isEnabled(true), .isEnabled(false))
        XCTAssertEqual(UIControlStyle.isSelected(true), .isSelected(true))
        XCTAssertNotEqual(UIControlStyle.isSelected(true), .isSelected(false))
        XCTAssertEqual(UIControlStyle.isHighlighted(true), .isHighlighted(true))
        XCTAssertNotEqual(UIControlStyle.isHighlighted(true), .isHighlighted(false))
        XCTAssertEqual(UIControlStyle.contentVerticalAlignment(.bottom), .contentVerticalAlignment(.bottom))
        XCTAssertNotEqual(UIControlStyle.contentVerticalAlignment(.bottom), .contentVerticalAlignment(.top))
        XCTAssertEqual(UIControlStyle.contentHorizontalAlignment(.center), .contentHorizontalAlignment(.center))
        XCTAssertNotEqual(UIControlStyle.contentHorizontalAlignment(.center), .contentHorizontalAlignment(.left))
        XCTAssertNotEqual(UIControlStyle.contentHorizontalAlignment(.center), .isSelected(true))
    }
    
    func testStyleSideEffects() {
        let view = UIControl()
        
        view.isEnabled = true
        UIControlStyle.isEnabled(false).sideEffect(on: view)
        XCTAssertEqual(view.isEnabled, false)
        
        view.isSelected = true
        UIControlStyle.isSelected(false).sideEffect(on: view)
        XCTAssertEqual(view.isSelected, false)
        
        view.isHighlighted = true
        UIControlStyle.isHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, false)
        
        view.contentVerticalAlignment = .bottom
        UIControlStyle.contentVerticalAlignment(.top).sideEffect(on: view)
        XCTAssertEqual(view.contentVerticalAlignment, .top)
        
        view.contentHorizontalAlignment = .left
        UIControlStyle.contentHorizontalAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.contentHorizontalAlignment, .center)
        
        view.isSelected = true
        Component<UIControl>().control(.isSelected(false)).configure(item: view)
        XCTAssertEqual(view.isSelected, false)
    }
    
    func testHashValue() {
        var hashes = Set(TestUILabelStyle.accumulatedHashes)
        
        for item in TestUIControlStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
