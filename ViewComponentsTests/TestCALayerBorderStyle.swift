//
//  TestCALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 10/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestCALayerBorderStyle: XCTestCase {
    
    func testStyleEquatable() {
        XCTAssertEqual(CALayer.BorderStyle.cornerRadius(12), .cornerRadius(12))
        XCTAssertEqual(CALayer.BorderStyle.width(12), .width(12))
        XCTAssertEqual(CALayer.BorderStyle.color(.red), .color(.red))
        XCTAssertNotEqual(CALayer.BorderStyle.color(.red), .width(12))
    }
    
    func testStyleSideEffects() {
        let view = UIView()
        
        view.layer.cornerRadius = 1
        CALayer.BorderStyle.cornerRadius(12).sideEffect(on: view)
        XCTAssertEqual(view.layer.cornerRadius, 12)
        
        view.layer.borderWidth = 1
        CALayer.BorderStyle.width(12).sideEffect(on: view)
        XCTAssertEqual(view.layer.borderWidth, 12)
        
        view.layer.borderColor = UIColor.green.cgColor
        CALayer.BorderStyle.color(.red).sideEffect(on: view)
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
        
        view.layer.borderColor = UIColor.green.cgColor
        Component<UIView>().borderStyles(.color(.red)).configure(view: view)
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
    }
}
