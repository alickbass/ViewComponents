//
//  TestUISliderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUISliderStyle: XCTestCase {
    
    static let allStyles: [UISliderStyle] = [
        .currentValue(0.2, animated: true), .minimumValue(0.2), .maximumValue(0.2), .isContinuous(true),
        .minimumValueImage(nil), .minimumValueImage(UIImage()), .maximumValueImage(nil), .maximumValueImage(UIImage()),
        .minimumTrackTintColor(nil), .minimumTrackTintColor(.blue), .maximumTrackTintColor(nil), .maximumTrackTintColor(.blue),
        .thumbTintColor(nil), .thumbTintColor(.blue), .minimumTrackImage(nil, for: .normal), .minimumTrackImage(UIImage(), for: .normal),
        .maximumTrackImage(nil, for: .normal), .maximumTrackImage(UIImage(), for: .normal),
        .thumbImage(nil, for: .normal), .thumbImage(UIImage(), for: .normal)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestProgressViewStyle.accumulatedHashes + TestUISliderStyle.allStyles.map({ $0.hashValue })
    }
    
    let image = UIImage()
    
    func testStyleEquatable() {
        XCTAssertEqual(UISliderStyle.currentValue(0.2, animated: true), .currentValue(0.2, animated: true))
        XCTAssertEqual(UISliderStyle.minimumValue(0.2), .minimumValue(0.2))
        XCTAssertEqual(UISliderStyle.maximumValue(0.2), .maximumValue(0.2))
        XCTAssertEqual(UISliderStyle.isContinuous(true), .isContinuous(true))
        XCTAssertEqual(UISliderStyle.minimumValueImage(image), .minimumValueImage(image))
        XCTAssertEqual(UISliderStyle.maximumValueImage(image), .maximumValueImage(image))
        XCTAssertEqual(UISliderStyle.minimumTrackTintColor(.blue), .minimumTrackTintColor(.blue))
        XCTAssertEqual(UISliderStyle.minimumTrackImage(image, for: .normal), .minimumTrackImage(image, for: .normal))
        XCTAssertEqual(UISliderStyle.maximumTrackTintColor(.blue), .maximumTrackTintColor(.blue))
        XCTAssertEqual(UISliderStyle.maximumTrackImage(image, for: .normal), .maximumTrackImage(image, for: .normal))
        XCTAssertEqual(UISliderStyle.thumbTintColor(.blue), .thumbTintColor(.blue))
        XCTAssertEqual(UISliderStyle.thumbImage(image, for: .normal), .thumbImage(image, for: .normal))
        XCTAssertNotEqual(UISliderStyle.thumbImage(image, for: .normal), .thumbTintColor(.blue))
    }
    
    func testStyleSideEffects() {
        let view = UISlider()
        
        view.setValue(0.6, animated: false)
        UISliderStyle.currentValue(0.2, animated: false).sideEffect(on: view)
        XCTAssertEqual(view.value, 0.2)
        
        view.minimumValue = 0.0
        UISliderStyle.minimumValue(0.2).sideEffect(on: view)
        XCTAssertEqual(view.minimumValue, 0.2)
        
        view.maximumValue = 0.5
        UISliderStyle.maximumValue(0.8).sideEffect(on: view)
        XCTAssertEqual(view.maximumValue, 0.8)
        
        view.isContinuous = false
        UISliderStyle.isContinuous(true).sideEffect(on: view)
        XCTAssertEqual(view.isContinuous, true)
        
        view.minimumValueImage = nil
        UISliderStyle.minimumValueImage(image).sideEffect(on: view)
        XCTAssertEqual(view.minimumValueImage, image)
        
        view.maximumValueImage = nil
        UISliderStyle.maximumValueImage(image).sideEffect(on: view)
        XCTAssertEqual(view.maximumValueImage, image)
        
        view.minimumTrackTintColor = .red
        UISliderStyle.minimumTrackTintColor(.blue).sideEffect(on: view)
        XCTAssertEqual(view.minimumTrackTintColor, .blue)
        
        view.maximumTrackTintColor = .red
        UISliderStyle.maximumTrackTintColor(.blue).sideEffect(on: view)
        XCTAssertEqual(view.maximumTrackTintColor, .blue)
        
        view.thumbTintColor = .red
        UISliderStyle.thumbTintColor(.blue).sideEffect(on: view)
        XCTAssertEqual(view.thumbTintColor, .blue)
        
        view.setMinimumTrackImage(nil, for: .normal)
        UISliderStyle.minimumTrackImage(image, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.minimumTrackImage(for: .normal), image)
        
        view.setMaximumTrackImage(nil, for: .normal)
        UISliderStyle.maximumTrackImage(image, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.maximumTrackImage(for: .normal), image)
        
        view.setThumbImage(nil, for: .normal)
        UISliderStyle.thumbImage(image, for: .normal).sideEffect(on: view)
        XCTAssertEqual(view.thumbImage(for: .normal), image)
        
        view.minimumValue = 0.0
        Component<UISlider>().slider(.minimumValue(0.2)).configure(view: view)
        XCTAssertEqual(view.minimumValue, 0.2)
    }
    
    func testHashValue() {
        var hashes = Set(TestProgressViewStyle.accumulatedHashes)
        
        for item in TestUISliderStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
