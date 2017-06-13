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
        XCTAssertEqual(UIViewStyle.contentMode(.scaleToFill), .contentMode(.scaleToFill))
        XCTAssertNotEqual(UIViewStyle.contentMode(.scaleToFill), .contentMode(.center))
    }
    
    func testStyleSideEffects() {
        let view = UIView()
        
        view.backgroundColor = .red
        UIViewStyle.backgroundColor(.green).sideEffect(on: view)
        XCTAssertEqual(view.backgroundColor, .green)
        
        view.isHidden = false
        UIViewStyle.isHidden(true).sideEffect(on: view)
        XCTAssertEqual(view.isHidden, true)
        
        view.alpha = 0.4
        UIViewStyle.alpha(0.3).sideEffect(on: view)
        XCTAssertEqualWithAccuracy(view.alpha, 0.3, accuracy: 0.001)
        
        view.isOpaque = false
        UIViewStyle.isOpaque(true).sideEffect(on: view)
        XCTAssertEqual(view.isOpaque, true)
        
        view.tintColor = .gray
        UIViewStyle.tintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.tintColor, .red)
        
        view.tintAdjustmentMode = .dimmed
        UIViewStyle.tintAdjustmentMode(.normal).sideEffect(on: view)
        XCTAssertEqual(view.tintAdjustmentMode, .normal)
        
        view.clipsToBounds = false
        UIViewStyle.clipsToBounds(true).sideEffect(on: view)
        XCTAssertEqual(view.clipsToBounds, true)
        
        view.clearsContextBeforeDrawing = false
        UIViewStyle.clearsContextBeforeDrawing(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsContextBeforeDrawing, true)
        
        view.isUserInteractionEnabled = false
        UIViewStyle.isUserInteractionEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isUserInteractionEnabled, true)
        
        view.isMultipleTouchEnabled = false
        UIViewStyle.isMultipleTouchEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isMultipleTouchEnabled, true)
        
        view.isExclusiveTouch = false
        UIViewStyle.isExclusiveTouch(true).sideEffect(on: view)
        XCTAssertEqual(view.isExclusiveTouch, true)
        
        view.contentMode = .scaleToFill
        UIViewStyle.contentMode(.center).sideEffect(on: view)
        XCTAssertEqual(view.contentMode, .center)
        
        view.isExclusiveTouch = false
        Component<UIView>().view(.isExclusiveTouch(true)).configure(item: view)
        XCTAssertEqual(view.isExclusiveTouch, true)
    }
    
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
        XCTAssertEqual(UIViewStyle.Key.backgroundColor.rawValue, CALayer.BorderStyle.Key.color.rawValue + 1)
        testAccumulatingHashes()
    }
}
