//
//  TestProgressViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestProgressViewStyle: XCTestCase {
    
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
        Component<UIProgressView>().progressViewStyles(.trackImage(image)).configure(view: view)
        XCTAssertEqual(view.trackImage, image)
    }
    
}
