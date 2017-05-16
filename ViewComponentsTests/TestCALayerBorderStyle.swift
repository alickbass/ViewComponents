//
//  TestCALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 10/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestCALayerBorderStyle: XCTestCase {
    
    static let allStyles: [CALayer.BorderStyle] = [
        .cornerRadius(12), .width(12), .color(.red), .color(nil)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestCALayerShadowStyle.accumulatedHashes + TestCALayerBorderStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(CALayer.BorderStyle.cornerRadius(12), .cornerRadius(12))
        XCTAssertEqual(CALayer.BorderStyle.width(12), .width(12))
        XCTAssertEqual(CALayer.BorderStyle.color(.red), .color(.red))
        XCTAssertNotEqual(CALayer.BorderStyle.color(.red), .width(12))
    }
    
    func testStyleSideEffects() {
        let view = UIView()
        
        view.layer.cornerRadius = 1
        CALayer.BorderStyle.cornerRadius(12).sideEffect(on: view)
        XCTAssertEqual(view.layer.cornerRadius, 12)
        
        view.layer.borderWidth = 1
        CALayer.BorderStyle.width(12).sideEffect(on: view)
        XCTAssertEqual(view.layer.borderWidth, 12)
        
        view.layer.borderColor = UIColor.green.cgColor
        CALayer.BorderStyle.color(.red).sideEffect(on: view)
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
        
        view.layer.borderColor = UIColor.green.cgColor
        Component<UIView>().border(.color(.red)).configure(item: view)
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
    }
    
    func testHashValue() {
        var hashes = Set(TestCALayerShadowStyle.accumulatedHashes)
        
        for item in TestCALayerBorderStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
