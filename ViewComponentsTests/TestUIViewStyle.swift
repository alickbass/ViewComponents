//
//  TestUIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIView>] = [
        .backgroundColor(.red), .backgroundColor(nil), .isHidden(true), .alpha(0.2),
        .isOpaque(true), .tintColor(.red), .tintAdjustmentMode(.automatic), .clipsToBounds(true),
        .clearsContextBeforeDrawing(true), .isUserInteractionEnabled(true), .isMultipleTouchEnabled(true),
        .isExclusiveTouch(true), .contentMode(.scaleToFill)
    ]
    
    static var previousHashes: [Int : Any] { return TestCALayerBorderStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UIView()
        
        view.backgroundColor = .red
        AnyStyle<UIView>.backgroundColor(.green).sideEffect(on: view)
        XCTAssertEqual(view.backgroundColor, .green)
        
        view.isHidden = false
        AnyStyle<UIView>.isHidden(true).sideEffect(on: view)
        XCTAssertEqual(view.isHidden, true)
        
        view.alpha = 0.4
        AnyStyle<UIView>.alpha(0.3).sideEffect(on: view)
        XCTAssertEqualWithAccuracy(view.alpha, 0.3, accuracy: 0.001)
        
        view.isOpaque = false
        AnyStyle<UIView>.isOpaque(true).sideEffect(on: view)
        XCTAssertEqual(view.isOpaque, true)
        
        view.tintColor = .gray
        AnyStyle<UIView>.tintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.tintColor, .red)
        
        view.tintAdjustmentMode = .dimmed
        AnyStyle<UIView>.tintAdjustmentMode(.normal).sideEffect(on: view)
        XCTAssertEqual(view.tintAdjustmentMode, .normal)
        
        view.clipsToBounds = false
        AnyStyle<UIView>.clipsToBounds(true).sideEffect(on: view)
        XCTAssertEqual(view.clipsToBounds, true)
        
        view.clearsContextBeforeDrawing = false
        AnyStyle<UIView>.clearsContextBeforeDrawing(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsContextBeforeDrawing, true)
        
        view.isUserInteractionEnabled = false
        AnyStyle<UIView>.isUserInteractionEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isUserInteractionEnabled, true)
        
        view.isMultipleTouchEnabled = false
        AnyStyle<UIView>.isMultipleTouchEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isMultipleTouchEnabled, true)
        
        view.isExclusiveTouch = false
        AnyStyle<UIView>.isExclusiveTouch(true).sideEffect(on: view)
        XCTAssertEqual(view.isExclusiveTouch, true)
        
        view.contentMode = .scaleToFill
        AnyStyle<UIView>.contentMode(.center).sideEffect(on: view)
        XCTAssertEqual(view.contentMode, .center)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
