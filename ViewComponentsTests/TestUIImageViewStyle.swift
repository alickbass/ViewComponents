//
//  TestUIImageViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIImageViewStyle: XCTestCase, ViewTestType {
    let image = UIImage()
    
    static let allStyles: [AnyStyle<UIImageView>] = [
        AnyStyle<UIImageView>.image(UIImage()), AnyStyle<UIImageView>.image(nil),
        AnyStyle<UIImageView>.highlightedImage(UIImage()), AnyStyle<UIImageView>.highlightedImage(nil),
        AnyStyle<UIImageView>.highlightedAnimationImages([UIImage()]), AnyStyle<UIImageView>.highlightedAnimationImages(nil),
        AnyStyle<UIImageView>.animationImages([UIImage()]), AnyStyle<UIImageView>.animationImages(nil),
        AnyStyle<UIImageView>.animationDuration(12), .animationRepeatCount(12), .isHighlighted(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUIButtonStyle.accumulatedHashes }
    
    func testAnyStyleEquatable() {
        XCTAssertEqual(AnyStyle<UIImageView>.animationImages([image]), .animationImages([image]))
        XCTAssertEqual(AnyStyle<UIImageView>.animationImages(nil), .animationImages(nil))
        XCTAssertNotEqual(AnyStyle<UIImageView>.animationImages([image]), .animationImages(nil))
        
        XCTAssertEqual(AnyStyle<UIImageView>.highlightedAnimationImages([image]), .highlightedAnimationImages([image]))
        XCTAssertEqual(AnyStyle<UIImageView>.highlightedAnimationImages(nil), .highlightedAnimationImages(nil))
        XCTAssertNotEqual(AnyStyle<UIImageView>.highlightedAnimationImages([image]), .highlightedAnimationImages(nil))
    }
    
    func testAnyStyleSideEffects() {
        let view = UIImageView()
        
        view.image = image
        AnyStyle<UIImageView>.image(nil).sideEffect(on: view)
        XCTAssertNil(view.image)
        
        view.highlightedImage = image
        AnyStyle<UIImageView>.highlightedImage(nil).sideEffect(on: view)
        XCTAssertNil(view.highlightedImage)
        
        view.animationImages = [image]
        AnyStyle<UIImageView>.animationImages(nil).sideEffect(on: view)
        XCTAssertNil(view.animationImages)
        
        view.highlightedAnimationImages = [image]
        AnyStyle<UIImageView>.highlightedAnimationImages(nil).sideEffect(on: view)
        XCTAssertNil(view.highlightedAnimationImages)
        
        view.animationDuration = 50
        AnyStyle<UIImageView>.animationDuration(12).sideEffect(on: view)
        XCTAssertEqual(view.animationDuration, 12)
        
        view.animationRepeatCount = 50
        AnyStyle<UIImageView>.animationRepeatCount(12).sideEffect(on: view)
        XCTAssertEqual(view.animationRepeatCount, 12)
        
        view.isHighlighted = false
        AnyStyle<UIImageView>.isHighlighted(true).sideEffect(on: view)
        XCTAssertTrue(view.isHighlighted)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
