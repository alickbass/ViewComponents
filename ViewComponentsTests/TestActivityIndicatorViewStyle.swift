//
//  TestActivityIndicatorViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestActivityIndicatorViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIActivityIndicatorView>] = [
        .isAnimating(true), .hidesWhenStopped(true), .activityIndicatorViewStyle(.gray),
        .color(.gray), .color(.none)
    ]
    
    static var previousHashes: [Int : Any] { return TestUISliderStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UIActivityIndicatorView()
        
        view.stopAnimating()
        AnyStyle<UIActivityIndicatorView>.isAnimating(true).sideEffect(on: view)
        XCTAssertEqual(view.isAnimating, true)
        AnyStyle<UIActivityIndicatorView>.isAnimating(false).sideEffect(on: view)
        XCTAssertEqual(view.isAnimating, false)
        
        view.hidesWhenStopped = false
        AnyStyle<UIActivityIndicatorView>.hidesWhenStopped(true).sideEffect(on: view)
        XCTAssertEqual(view.hidesWhenStopped, true)
        
        view.activityIndicatorViewStyle = .whiteLarge
        AnyStyle<UIActivityIndicatorView>.activityIndicatorViewStyle(.gray).sideEffect(on: view)
        XCTAssertEqual(view.activityIndicatorViewStyle, .gray)
        
        view.color = nil
        AnyStyle<UIActivityIndicatorView>.color(.gray).sideEffect(on: view)
        XCTAssertEqual(view.color, .gray)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
