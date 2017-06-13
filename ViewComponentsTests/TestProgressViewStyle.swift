//
//  TestProgressViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestProgressViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [ProgressViewStyle<UIProgressView>] = [
        .progress(0.2, animated: true), .progressViewStyle(.bar), .progressTintColor(.red),
        .progressTintColor(nil), .progressImage(UIImage()), .progressImage(nil),
        .trackTintColor(.red), .trackTintColor(nil), .trackImage(UIImage()), .trackImage(nil)
    ]
    
    static var previousHashes: [Int : Any] { return TestUITextViewStyle.accumulatedHashes }
    
    let image = UIImage()
    
    func testStyleEquatable() {
        XCTAssertEqual(ProgressViewStyle.progress(0.2, animated: true), .progress(0.2, animated: true))
        XCTAssertEqual(ProgressViewStyle.progressViewStyle(.bar), .progressViewStyle(.bar))
        XCTAssertEqual(ProgressViewStyle.progressTintColor(.red), .progressTintColor(.red))
        XCTAssertEqual(ProgressViewStyle.progressImage(image), .progressImage(image))
        XCTAssertEqual(ProgressViewStyle.trackTintColor(.red), .trackTintColor(.red))
        XCTAssertEqual(ProgressViewStyle.trackImage(image), .trackImage(image))
        XCTAssertNotEqual(ProgressViewStyle.trackImage(image), .trackTintColor(.red))
    }
    
    func testAnyStyleEquatable() {
        XCTAssertEqual(AnyStyle<UIProgressView>.progress(0.2, animated: true), .progress(0.2, animated: true))
    }
    
    func testStyleSideEffects() {
        let view = UIProgressView()
        
        view.setProgress(0.5, animated: false)
        ProgressViewStyle.progress(0.2, animated: false).sideEffect(on: view)
        XCTAssertEqual(view.progress, 0.2)
        
        view.progressViewStyle = .default
        ProgressViewStyle.progressViewStyle(.bar).sideEffect(on: view)
        XCTAssertEqual(view.progressViewStyle, .bar)
        
        view.progressTintColor = .blue
        ProgressViewStyle.progressTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.progressTintColor, .red)
        
        view.progressImage = nil
        ProgressViewStyle.progressImage(image).sideEffect(on: view)
        XCTAssertEqual(view.progressImage, image)
        
        view.trackTintColor = .blue
        ProgressViewStyle.trackTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.trackTintColor, .red)
        
        view.trackImage = nil
        ProgressViewStyle.trackImage(image).sideEffect(on: view)
        XCTAssertEqual(view.trackImage, image)
        
        view.trackImage = nil
        Component<UIProgressView>().progressView(.trackImage(image)).configure(item: view)
        XCTAssertEqual(view.trackImage, image)
    }
    
    func testAnyStyleSideEffects() {
        let view = UIProgressView()
        
        view.setProgress(0.5, animated: false)
        AnyStyle<UIProgressView>.progress(0.2, animated: false).sideEffect(on: view)
        XCTAssertEqual(view.progress, 0.2)
        
        view.progressViewStyle = .default
        AnyStyle<UIProgressView>.progressViewStyle(.bar).sideEffect(on: view)
        XCTAssertEqual(view.progressViewStyle, .bar)
        
        view.progressTintColor = .blue
        AnyStyle<UIProgressView>.progressTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.progressTintColor, .red)
        
        view.progressImage = nil
        AnyStyle<UIProgressView>.progressImage(image).sideEffect(on: view)
        XCTAssertEqual(view.progressImage, image)
        
        view.trackTintColor = .blue
        AnyStyle<UIProgressView>.trackTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.trackTintColor, .red)
        
        view.trackImage = nil
        AnyStyle<UIProgressView>.trackImage(image).sideEffect(on: view)
        XCTAssertEqual(view.trackImage, image)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
