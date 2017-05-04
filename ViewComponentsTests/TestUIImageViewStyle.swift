//
//  TestUIImageViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIImageViewStyle: XCTestCase {
    
    func testStyleEquatable() {
        let image = UIImage()
        
        XCTAssertEqual(UIImageViewStyle.image(image), .image(image))
        XCTAssertNotEqual(UIImageViewStyle.image(image), .image(nil))
        
        XCTAssertEqual(UIImageViewStyle.highlightedImage(image), .highlightedImage(image))
        XCTAssertNotEqual(UIImageViewStyle.highlightedImage(image), .highlightedImage(nil))
        
        XCTAssertEqual(UIImageViewStyle.animationImages([image]), .animationImages([image]))
        XCTAssertEqual(UIImageViewStyle.animationImages(nil), .animationImages(nil))
        XCTAssertNotEqual(UIImageViewStyle.animationImages([image]), .animationImages(nil))
        
        XCTAssertEqual(UIImageViewStyle.animationDuration(12), .animationDuration(12))
        XCTAssertNotEqual(UIImageViewStyle.animationDuration(12), .animationDuration(20))
        
        XCTAssertEqual(UIImageViewStyle.animationRepeatCount(12), .animationRepeatCount(12))
        XCTAssertNotEqual(UIImageViewStyle.animationRepeatCount(12), .animationRepeatCount(20))
        
        XCTAssertEqual(UIImageViewStyle.isHighlighted(true), .isHighlighted(true))
        XCTAssertNotEqual(UIImageViewStyle.isHighlighted(true), .isHighlighted(false))
        XCTAssertNotEqual(UIImageViewStyle.isHighlighted(true), .animationRepeatCount(20))
    }
    
}
