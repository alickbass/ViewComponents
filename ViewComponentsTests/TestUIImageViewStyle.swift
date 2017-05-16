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
    let image = UIImage()
    
    static let allStyles: [UIImageViewStyle] = [
        UIImageViewStyle.image(UIImage()), UIImageViewStyle.image(nil),
        UIImageViewStyle.highlightedImage(UIImage()), UIImageViewStyle.highlightedImage(nil),
        UIImageViewStyle.highlightedAnimationImages([UIImage()]), UIImageViewStyle.highlightedAnimationImages(nil),
        UIImageViewStyle.animationImages([UIImage()]), UIImageViewStyle.animationImages(nil),
        UIImageViewStyle.animationDuration(12), .animationRepeatCount(12), .isHighlighted(true)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUIButtonStyle.accumulatedHashes + TestUIImageViewStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(UIImageViewStyle.image(image), .image(image))
        XCTAssertNotEqual(UIImageViewStyle.image(image), .image(nil))
        
        XCTAssertEqual(UIImageViewStyle.highlightedImage(image), .highlightedImage(image))
        XCTAssertNotEqual(UIImageViewStyle.highlightedImage(image), .highlightedImage(nil))
        
        XCTAssertEqual(UIImageViewStyle.animationImages([image]), .animationImages([image]))
        XCTAssertEqual(UIImageViewStyle.animationImages(nil), .animationImages(nil))
        XCTAssertNotEqual(UIImageViewStyle.animationImages([image]), .animationImages(nil))
        
        XCTAssertEqual(UIImageViewStyle.highlightedAnimationImages([image]), .highlightedAnimationImages([image]))
        XCTAssertEqual(UIImageViewStyle.highlightedAnimationImages(nil), .highlightedAnimationImages(nil))
        XCTAssertNotEqual(UIImageViewStyle.highlightedAnimationImages([image]), .highlightedAnimationImages(nil))
        
        XCTAssertEqual(UIImageViewStyle.animationDuration(12), .animationDuration(12))
        XCTAssertNotEqual(UIImageViewStyle.animationDuration(12), .animationDuration(20))
        
        XCTAssertEqual(UIImageViewStyle.animationRepeatCount(12), .animationRepeatCount(12))
        XCTAssertNotEqual(UIImageViewStyle.animationRepeatCount(12), .animationRepeatCount(20))
        
        XCTAssertEqual(UIImageViewStyle.isHighlighted(true), .isHighlighted(true))
        XCTAssertNotEqual(UIImageViewStyle.isHighlighted(true), .isHighlighted(false))
        XCTAssertNotEqual(UIImageViewStyle.isHighlighted(true), .animationRepeatCount(20))
    }
    
    func testStyleSideEffects() {
        let view = UIImageView()
        
        view.image = image
        UIImageViewStyle.image(nil).sideEffect(on: view)
        XCTAssertNil(view.image)
        
        view.highlightedImage = image
        UIImageViewStyle.highlightedImage(nil).sideEffect(on: view)
        XCTAssertNil(view.highlightedImage)
        
        view.animationImages = [image]
        UIImageViewStyle.animationImages(nil).sideEffect(on: view)
        XCTAssertNil(view.animationImages)
        
        view.highlightedAnimationImages = [image]
        UIImageViewStyle.highlightedAnimationImages(nil).sideEffect(on: view)
        XCTAssertNil(view.highlightedAnimationImages)
        
        view.animationDuration = 50
        UIImageViewStyle.animationDuration(12).sideEffect(on: view)
        XCTAssertEqual(view.animationDuration, 12)
        
        view.animationRepeatCount = 50
        UIImageViewStyle.animationRepeatCount(12).sideEffect(on: view)
        XCTAssertEqual(view.animationRepeatCount, 12)
        
        view.isHighlighted = false
        UIImageViewStyle.isHighlighted(true).sideEffect(on: view)
        XCTAssertTrue(view.isHighlighted)
        
        view.isHighlighted = false
        Component<UIImageView>().imageView(.isHighlighted(true)).configure(view: view)
        XCTAssertEqual(view.isHighlighted, true)
    }
    
    func testHashValue() {
        var hashes = Set(TestUIButtonStyle.accumulatedHashes)
        
        for item in TestUIImageViewStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
