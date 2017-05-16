//
//  TestUISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUISwitchStyle: XCTestCase {
    
    static let allStyles: [UISwitchStyle] = [
        .isOn(true, animated: true), .onTintColor(nil), .onTintColor(.red),
        .thumbTintColor(nil), .thumbTintColor(.red), .onImage(nil), .onImage(UIImage()),
        .offImage(nil), .offImage(UIImage())
    ]
    
    static var accumulatedHashes: [Int] {
        return TestActivityIndicatorViewStyle.accumulatedHashes + TestUISwitchStyle.allStyles.map({ $0.hashValue })
    }
    
    let image = UIImage()
    
    func testStyleEquatable() {
        XCTAssertEqual(UISwitchStyle.isOn(true, animated: true), .isOn(true, animated: true))
        XCTAssertEqual(UISwitchStyle.onTintColor(.red), .onTintColor(.red))
        XCTAssertEqual(UISwitchStyle.thumbTintColor(.red), .thumbTintColor(.red))
        XCTAssertEqual(UISwitchStyle.onImage(image), .onImage(image))
        XCTAssertEqual(UISwitchStyle.offImage(image), .offImage(image))
        XCTAssertNotEqual(UISwitchStyle.offImage(image), .onImage(image))
    }
    
    func testStyleSideEffects() {
        let view = UISwitch()
        
        view.setOn(false, animated: false)
        UISwitchStyle.isOn(true, animated: false).sideEffect(on: view)
        XCTAssertEqual(view.isOn, true)
        
        view.onTintColor = nil
        UISwitchStyle.onTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.onTintColor, .red)
        
        view.thumbTintColor = nil
        UISwitchStyle.thumbTintColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.thumbTintColor, .red)
        
        view.onImage = nil
        UISwitchStyle.onImage(image).sideEffect(on: view)
        XCTAssertEqual(view.onImage, image)
        
        view.offImage = nil
        UISwitchStyle.offImage(image).sideEffect(on: view)
        XCTAssertEqual(view.offImage, image)
        
        view.offImage = nil
        Component<UISwitch>().switch(.offImage(image)).configure(view: view)
        XCTAssertEqual(view.offImage, image)
    }
    
    func testHashValue() {
        var hashes = Set(TestActivityIndicatorViewStyle.accumulatedHashes)
        
        for item in TestUISwitchStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
