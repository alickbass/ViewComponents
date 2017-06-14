//
//  TestUIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 02/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
@testable import ViewComponents

class TestUIButtonStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIButton>] = [
        .title("some", for: .normal), .title(nil, for: .normal),
        .attributedTitle(.init(string: "some"), for: .normal), .attributedTitle(nil, for: .normal),
        .titleColor(.red, for: .normal), .titleColor(nil, for: .normal),
        .titleShadowColor(.red, for: .normal), .titleShadowColor(nil, for: .normal),
        .reversesTitleShadowWhenHighlighted(true), .adjustsImageWhenHighlighted(true),
        .adjustsImageWhenDisabled(true), .showsTouchWhenHighlighted(true),
        .backgroundImage(UIImage(), for: .normal), .backgroundImage(nil, for: .normal),
        .image(UIImage(), for: .normal), .image(nil, for: .normal),
        .contentEdgeInsets(.zero), .titleEdgeInsets(.zero), .imageEdgeInsets(.zero)
    ]
    
    static var previousHashes: [Int : Any] { return TestUIControlStyle.accumulatedHashes }
    
    func testStateInputHashable() {
        XCTAssertEqual(StateInput(value: 3, state: .normal), StateInput(value: 3, state: .normal))
        XCTAssertEqual(StateInput(value: 3, state: .normal).hashValue, StateInput(value: 3, state: .normal).hashValue)
        XCTAssertNotEqual(StateInput(value: 3, state: .normal).hashValue, StateInput<Int>(value: .none, state: .normal).hashValue)
    }
    
    func testAnyStyleSideEffects() {
        let view = UIButton()
        
        view.setTitle(nil, for: .normal)
        AnyStyle<UIButton>.title("some", for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.title(for: .normal), "some")
        
        view.setAttributedTitle(nil, for: .normal)
        AnyStyle<UIButton>.attributedTitle(.init(string: "some"), for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.attributedTitle(for: .normal), .init(string: "some"))
        
        view.setTitleColor(.green, for: .normal)
        AnyStyle<UIButton>.titleColor(.red, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.titleColor(for: .normal), .red)
        
        view.setTitleShadowColor(.green, for: .normal)
        AnyStyle<UIButton>.titleShadowColor(.red, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.titleShadowColor(for: .normal), .red)
        
        view.reversesTitleShadowWhenHighlighted = true
        AnyStyle<UIButton>.reversesTitleShadowWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.reversesTitleShadowWhenHighlighted, false)
        
        view.adjustsImageWhenHighlighted = true
        AnyStyle<UIButton>.adjustsImageWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsImageWhenHighlighted, false)
        
        view.adjustsImageWhenDisabled = true
        AnyStyle<UIButton>.adjustsImageWhenDisabled(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsImageWhenDisabled, false)
        
        view.showsTouchWhenHighlighted = true
        AnyStyle<UIButton>.showsTouchWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.showsTouchWhenHighlighted, false)
        
        view.setBackgroundImage(UIImage(), for: .normal)
        AnyStyle<UIButton>.backgroundImage(.none, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.backgroundImage(for: .normal), .none)
        
        view.setImage(UIImage(), for: .normal)
        AnyStyle<UIButton>.image(.none, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.image(for: .normal), .none)
        
        view.contentEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        AnyStyle<UIButton>.contentEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentEdgeInsets, .zero)
        
        view.titleEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        AnyStyle<UIButton>.titleEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.titleEdgeInsets, .zero)
        
        view.imageEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        AnyStyle<UIButton>.imageEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.imageEdgeInsets, .zero)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
