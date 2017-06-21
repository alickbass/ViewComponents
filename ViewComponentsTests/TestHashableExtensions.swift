//
//  TestHashableExtensions.swift
//  ViewComponents
//
//  Created by Oleksii on 11/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestHashableExtensions: XCTestCase {
    
    func testCGPoint() {
        XCTAssertEqual(CGPoint(x: 20, y: 20).hashValue, CGPoint(x: 20, y: 20).hashValue)
        XCTAssertNotEqual(CGPoint(x: 0, y: 0).hashValue, CGPoint(x: 20, y: 20).hashValue)
    }
    
    func testCGSize() {
        XCTAssertEqual(CGSize(width: 20, height: 20).hashValue, CGSize(width: 20, height: 20).hashValue)
        XCTAssertNotEqual(CGSize(width: 0, height: 0).hashValue, CGSize(width: 20, height: 20).hashValue)
    }
    
    func testCGRect() {
        XCTAssertEqual(CGRect(x: 20, y: 20, width: 20, height: 20).hashValue, CGRect(x: 20, y: 20, width: 20, height: 20).hashValue)
        XCTAssertNotEqual(CGRect(x: 20, y: 20, width: 20, height: 20).hashValue, CGRect(x: 0, y: 0, width: 20, height: 20).hashValue)
    }
    
    func testUIControlStateCustomString() {
        XCTAssertEqual(UIControlState.normal.description, "normal")
        XCTAssertEqual(UIControlState.highlighted.description, "highlighted")
        XCTAssertEqual(UIControlState.disabled.description, "disabled")
        XCTAssertEqual(UIControlState.selected.description, "selected")
        XCTAssertEqual(UIControlState.focused.description, "focused")
        XCTAssertEqual(UIControlState.application.description, "application")
        XCTAssertEqual(UIControlState.reserved.description, "reserved")
        XCTAssertEqual(UIControlState(rawValue: 100).description, "100")
    }
    
}
