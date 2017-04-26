//
//  TestUIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIViewStyle: XCTestCase {
    
    func testStyleEquatable() {
        XCTAssertEqual(UIViewStyle.backgroundColor(.red), .backgroundColor(.red))
        XCTAssertNotEqual(UIViewStyle.backgroundColor(.red), .backgroundColor(.green))
        XCTAssertEqual(UIViewStyle.isHidden(true), .isHidden(true))
        XCTAssertNotEqual(UIViewStyle.isHidden(true), .isHidden(false))
        XCTAssertEqual(UIViewStyle.alpha(0.2), .alpha(0.2))
        XCTAssertNotEqual(UIViewStyle.alpha(0.2), .alpha(0.3))
        XCTAssertEqual(UIViewStyle.isOpaque(true), .isOpaque(true))
        XCTAssertNotEqual(UIViewStyle.isOpaque(true), .isOpaque(false))
        XCTAssertEqual(UIViewStyle.tintColor(.red), .tintColor(.red))
        XCTAssertNotEqual(UIViewStyle.tintColor(.red), .tintColor(.green))
        XCTAssertEqual(UIViewStyle.tintAdjustmentMode(.automatic), .tintAdjustmentMode(.automatic))
        XCTAssertNotEqual(UIViewStyle.tintAdjustmentMode(.automatic), .tintAdjustmentMode(.dimmed))
        XCTAssertEqual(UIViewStyle.clipsToBounds(true), .clipsToBounds(true))
        XCTAssertNotEqual(UIViewStyle.clipsToBounds(true), .clipsToBounds(false))
        XCTAssertEqual(UIViewStyle.clearsContextBeforeDrawing(true), .clearsContextBeforeDrawing(true))
        XCTAssertNotEqual(UIViewStyle.clearsContextBeforeDrawing(true), .clearsContextBeforeDrawing(false))
        XCTAssertEqual(UIViewStyle.isUserInteractionEnabled(true), .isUserInteractionEnabled(true))
        XCTAssertNotEqual(UIViewStyle.isUserInteractionEnabled(true), .isUserInteractionEnabled(false))
        XCTAssertEqual(UIViewStyle.isMultipleTouchEnabled(true), .isMultipleTouchEnabled(true))
        XCTAssertNotEqual(UIViewStyle.isMultipleTouchEnabled(true), .isMultipleTouchEnabled(false))
        XCTAssertEqual(UIViewStyle.isExclusiveTouch(true), .isExclusiveTouch(true))
        XCTAssertNotEqual(UIViewStyle.isExclusiveTouch(true), .isExclusiveTouch(false))
        XCTAssertNotEqual(UIViewStyle.isExclusiveTouch(true), .isMultipleTouchEnabled(false))
    }
    
}
