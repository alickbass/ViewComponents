//
//  TestUIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 02/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIButtonStyle: XCTestCase {
    
    func testStyleEquatable() {
        XCTAssertEqual(UIButtonStyle.title("some", for: .normal), .title("some", for: .normal))
        XCTAssertNotEqual(UIButtonStyle.title("some", for: .normal), .title(nil, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.title("some", for: .normal), .title("some", for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.attributedTitle(.init(string: "some"), for: .normal), .attributedTitle(.init(string: "some"), for: .normal))
        XCTAssertNotEqual(UIButtonStyle.attributedTitle(.init(string: "some"), for: .normal), .attributedTitle(.init(string: "test"), for: .normal))
        XCTAssertNotEqual(UIButtonStyle.attributedTitle(.init(string: "some"), for: .normal), .attributedTitle(.init(string: "some"), for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.titleColor(.red, for: .normal), .titleColor(.red, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.titleColor(.red, for: .normal), .titleColor(.green, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.titleColor(.red, for: .normal), .titleColor(.red, for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.titleShadowColor(.red, for: .normal), .titleShadowColor(.red, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.titleShadowColor(.red, for: .normal), .titleShadowColor(.green, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.titleShadowColor(.red, for: .normal), .titleShadowColor(.red, for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.reversesTitleShadowWhenHighlighted(true), .reversesTitleShadowWhenHighlighted(true))
        XCTAssertNotEqual(UIButtonStyle.reversesTitleShadowWhenHighlighted(true), .reversesTitleShadowWhenHighlighted(false))
        
        XCTAssertEqual(UIButtonStyle.adjustsImageWhenHighlighted(true), .adjustsImageWhenHighlighted(true))
        XCTAssertNotEqual(UIButtonStyle.adjustsImageWhenHighlighted(true), .adjustsImageWhenHighlighted(false))
        
        XCTAssertEqual(UIButtonStyle.adjustsImageWhenDisabled(true), .adjustsImageWhenDisabled(true))
        XCTAssertNotEqual(UIButtonStyle.adjustsImageWhenDisabled(true), .adjustsImageWhenDisabled(false))
        
        XCTAssertEqual(UIButtonStyle.showsTouchWhenHighlighted(true), .showsTouchWhenHighlighted(true))
        XCTAssertNotEqual(UIButtonStyle.showsTouchWhenHighlighted(true), .showsTouchWhenHighlighted(false))
        
        let image = UIImage()
        XCTAssertEqual(UIButtonStyle.backgroundImage(image, for: .normal), .backgroundImage(image, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.backgroundImage(image, for: .normal), .backgroundImage(.none, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.backgroundImage(image, for: .normal), .backgroundImage(image, for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.image(image, for: .normal), .image(image, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.image(image, for: .normal), .image(.none, for: .normal))
        XCTAssertNotEqual(UIButtonStyle.image(image, for: .normal), .image(image, for: .disabled))
        
        XCTAssertEqual(UIButtonStyle.contentEdgeInsets(.zero), .contentEdgeInsets(.zero))
        XCTAssertNotEqual(UIButtonStyle.contentEdgeInsets(.zero), .contentEdgeInsets(.init(top: 0, left: 2, bottom: 2, right: 2)))
        
        XCTAssertEqual(UIButtonStyle.titleEdgeInsets(.zero), .titleEdgeInsets(.zero))
        XCTAssertNotEqual(UIButtonStyle.titleEdgeInsets(.zero), .titleEdgeInsets(.init(top: 0, left: 2, bottom: 2, right: 2)))
        
        XCTAssertEqual(UIButtonStyle.imageEdgeInsets(.zero), .imageEdgeInsets(.zero))
        XCTAssertNotEqual(UIButtonStyle.imageEdgeInsets(.zero), .imageEdgeInsets(.init(top: 0, left: 2, bottom: 2, right: 2)))
        XCTAssertNotEqual(UIButtonStyle.imageEdgeInsets(.zero), .titleEdgeInsets(.init(top: 0, left: 2, bottom: 2, right: 2)))
    }
    
    func testStyleSideEffects() {
        let view = UIButton()
        
        view.setTitle(nil, for: .normal)
        UIButtonStyle.title("some", for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.title(for: .normal), "some")
        
        view.setAttributedTitle(nil, for: .normal)
        UIButtonStyle.attributedTitle(.init(string: "some"), for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.attributedTitle(for: .normal), .init(string: "some"))
        
        view.setTitleColor(.green, for: .normal)
        UIButtonStyle.titleColor(.red, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.titleColor(for: .normal), .red)
        
        view.setTitleShadowColor(.green, for: .normal)
        UIButtonStyle.titleShadowColor(.red, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.titleShadowColor(for: .normal), .red)
        
        view.reversesTitleShadowWhenHighlighted = true
        UIButtonStyle.reversesTitleShadowWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.reversesTitleShadowWhenHighlighted, false)
        
        view.adjustsImageWhenHighlighted = true
        UIButtonStyle.adjustsImageWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsImageWhenHighlighted, false)
        
        view.adjustsImageWhenDisabled = true
        UIButtonStyle.adjustsImageWhenDisabled(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsImageWhenDisabled, false)
        
        view.showsTouchWhenHighlighted = true
        UIButtonStyle.showsTouchWhenHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.showsTouchWhenHighlighted, false)
        
        view.setBackgroundImage(UIImage(), for: .normal)
        UIButtonStyle.backgroundImage(.none, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.backgroundImage(for: .normal), .none)
        
        view.setImage(UIImage(), for: .normal)
        UIButtonStyle.image(.none, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.image(for: .normal), .none)
        
        view.contentEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        UIButtonStyle.contentEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentEdgeInsets, .zero)
        
        view.titleEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        UIButtonStyle.titleEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.titleEdgeInsets, .zero)
        
        view.imageEdgeInsets = .init(top: 0, left: 2, bottom: 2, right: 2)
        UIButtonStyle.imageEdgeInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.imageEdgeInsets, .zero)
        
        view.showsTouchWhenHighlighted = false
        Component<UIButton>().buttonStyles(.showsTouchWhenHighlighted(true)).configure(view: view)
        XCTAssertEqual(view.showsTouchWhenHighlighted, true)
    }
}
