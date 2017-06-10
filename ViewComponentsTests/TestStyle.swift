//
//  TestStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestStyle: XCTestCase {
    
    func testStyleSideEffect() {
        let view = UIView()
        
        view.backgroundColor = .red
        UIViewStyle.backgroundColor(.green).sideEffect(on: view)
        XCTAssertEqual(view.backgroundColor, .green)
    }
    
    func testAnyStyle() {
        XCTAssertEqual(AnyViewStyle(UIViewStyle.isHidden(true)), AnyViewStyle(UIViewStyle.isHidden(true)))
        XCTAssertNotEqual(AnyViewStyle(UIViewStyle.isHidden(true)), AnyViewStyle(UIViewStyle.isHidden(false)))
        XCTAssertNotEqual(AnyViewStyle(UIViewStyle.isHidden(true)), AnyViewStyle(UILabelStyle.isEnabled(false)))
        
        XCTAssertEqual(AnyViewStyle(UIViewStyle.isHidden(true)).hashValue, UIViewStyle.isHidden(true).hashValue)
    }
    
}
