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
    
}
