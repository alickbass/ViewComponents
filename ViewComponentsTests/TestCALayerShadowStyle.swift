//
//  TestCALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestCALayerShadowStyle: XCTestCase {
    static let allStyles: [CALayer.ShadowStyle<CALayer>] = [
        .opacity(0.2), .radius(2), .offset(.zero),
        .color(.red), .path(CGPath(rect: CGRect(x: 0, y: 0, width: 15, height: 15), transform: nil)), .path(nil), .color(nil)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestCALayerStyle.accumulatedHashes + TestCALayerShadowStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(CALayer.ShadowStyle.opacity(0.2), .opacity(0.2))
        XCTAssertEqual(CALayer.ShadowStyle.radius(2), .radius(2))
        XCTAssertEqual(CALayer.ShadowStyle.offset(.zero), .offset(.zero))
        XCTAssertEqual(CALayer.ShadowStyle.color(.red), .color(.red))
        XCTAssertEqual(CALayer.ShadowStyle.path(nil), .path(nil))
        XCTAssertNotEqual(CALayer.ShadowStyle.opacity(2), .path(nil))
    }
    
    func testStyleSideEffects() {
        let view = CALayer()
        
        view.shadowOpacity = 1
        CALayer.ShadowStyle.opacity(0.2).sideEffect(on: view)
        XCTAssertEqual(view.shadowOpacity, 0.2)
        
        view.shadowRadius = 1
        CALayer.ShadowStyle.radius(2).sideEffect(on: view)
        XCTAssertEqual(view.shadowRadius, 2)
        
        view.shadowOffset = .init(width: 20, height: 20)
        CALayer.ShadowStyle.offset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.shadowOffset, .zero)
        
        view.shadowColor = UIColor.green.cgColor
        CALayer.ShadowStyle.color(.red).sideEffect(on: view)
        XCTAssertEqual(view.shadowColor, UIColor.red.cgColor)
        
        view.shadowPath = CGPath(rect: CGRect(x: 0, y: 0, width: 15, height: 15), transform: nil)
        CALayer.ShadowStyle.path(nil).sideEffect(on: view)
        XCTAssertNil(view.shadowPath)
        
        view.shadowColor = UIColor.green.cgColor
        Component<CALayer>().shadow(.color(.red)).configure(item: view)
        XCTAssertEqual(view.shadowColor, UIColor.red.cgColor)
        
        let theView = UIView()
        theView.layer.name = nil
        Component<UIView>().shadow(.color(.red)).configure(item: theView)
        XCTAssertEqual(view.shadowColor, UIColor.red.cgColor)
    }
    
    func testHashValue() {
        var hashes = Set(TestCALayerStyle.accumulatedHashes)
        
        for item in TestCALayerShadowStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
