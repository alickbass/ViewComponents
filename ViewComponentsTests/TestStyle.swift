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
        XCTAssertEqual(AnyStyle(UIViewStyle.isHidden(true)), AnyStyle(UIViewStyle.isHidden(true)))
        XCTAssertNotEqual(AnyStyle(UIViewStyle.isHidden(true)), AnyStyle(UIViewStyle.isHidden(false)))
        XCTAssertNotEqual(AnyStyle(UIViewStyle.isHidden(true)), AnyStyle(UILabelStyle.isEnabled(false)))
        
        XCTAssertEqual(AnyStyle(UIViewStyle.isHidden(true)).hashValue, UIViewStyle.isHidden(true).hashValue)
    }
    
}
