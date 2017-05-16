//
//  TestActivityIndicatorViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestActivityIndicatorViewStyle: XCTestCase {
    
    static let allStyles: [ActivityIndicatorViewStyle] = [
        .isAnimating(true), .hidesWhenStopped(true), .activityIndicatorViewStyle(.gray),
        .color(.gray), .color(.none)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUISliderStyle.accumulatedHashes + TestActivityIndicatorViewStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(ActivityIndicatorViewStyle.isAnimating(true), .isAnimating(true))
        XCTAssertEqual(ActivityIndicatorViewStyle.hidesWhenStopped(true), .hidesWhenStopped(true))
        XCTAssertEqual(ActivityIndicatorViewStyle.activityIndicatorViewStyle(.gray), .activityIndicatorViewStyle(.gray))
        XCTAssertEqual(ActivityIndicatorViewStyle.color(.gray), .color(.gray))
        XCTAssertNotEqual(ActivityIndicatorViewStyle.color(.gray), .activityIndicatorViewStyle(.gray))
    }
    
    func testStyleSideEffects() {
        let view = UIActivityIndicatorView()
        
        view.stopAnimating()
        ActivityIndicatorViewStyle.isAnimating(true).sideEffect(on: view)
        XCTAssertEqual(view.isAnimating, true)
        ActivityIndicatorViewStyle.isAnimating(false).sideEffect(on: view)
        XCTAssertEqual(view.isAnimating, false)
        
        view.hidesWhenStopped = false
        ActivityIndicatorViewStyle.hidesWhenStopped(true).sideEffect(on: view)
        XCTAssertEqual(view.hidesWhenStopped, true)
        
        view.activityIndicatorViewStyle = .whiteLarge
        ActivityIndicatorViewStyle.activityIndicatorViewStyle(.gray).sideEffect(on: view)
        XCTAssertEqual(view.activityIndicatorViewStyle, .gray)
        
        view.color = nil
        ActivityIndicatorViewStyle.color(.gray).sideEffect(on: view)
        XCTAssertEqual(view.color, .gray)
        
        view.color = nil
        Component<UIActivityIndicatorView>().activityIndicator(.color(.gray)).configure(item: view)
        XCTAssertEqual(view.color, .gray)
    }
    
    func testHashValue() {
        var hashes = Set(TestUISliderStyle.accumulatedHashes)
        
        for item in TestActivityIndicatorViewStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
