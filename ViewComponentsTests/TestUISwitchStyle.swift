//
//  TestUISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUISwitchStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UISwitch>] = [
        .isOn(true, animated: true), .onTintColor(nil), .onTintColor(.red),
        .thumbTintColor(nil), .thumbTintColor(.red), .onImage(nil), .onImage(UIImage()),
        .offImage(nil), .offImage(UIImage())
    ]
    
    static var previousHashes: [Int : Any] { return TestActivityIndicatorViewStyle.accumulatedHashes }
    
    let image = UIImage()
    
    func testAnyStyleEquatable() {
        XCTAssertEqual(AnyStyle<UISwitch>.isOn(true, animated: true), .isOn(true, animated: true))
    }
    
    func testAnyStyleSideEffects() {
        let view = UISwitch()
        
        view.setOn(false, animated: false)
        AnyStyle<UISwitch>.isOn(true, animated: false).sideEffect(on: view)
        XCTAssertEqual(view.isOn, true)
        
        view.onTintColor = nil
        AnyStyle<UISwitch>.onTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.onTintColor, .red)
        
        view.thumbTintColor = nil
        AnyStyle<UISwitch>.thumbTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.thumbTintColor, .red)
        
        view.onImage = nil
        AnyStyle<UISwitch>.onImage(image).sideEffect(on: view)
        XCTAssertEqual(view.onImage, image)
        
        view.offImage = nil
        AnyStyle<UISwitch>.offImage(image).sideEffect(on: view)
        XCTAssertEqual(view.offImage, image)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
