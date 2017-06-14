//
//  TestCALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
@testable import ViewComponents

class TestCALayerShadowStyle: XCTestCase, ViewTestType {
    static let allStyles: [AnyStyle<CALayer>] = [
        .shadow(opacity: 0.2, radius: 0.2, offset: .zero, color: nil, path: nil),
        .shadow(opacity: 0.2, radius: 0.2, offset: .zero, color: .red, path: CGPath(rect: .zero, transform: nil)),
    ]
    
    static var previousHashes: [Int : Any] {
        return TestCALayerStyle.accumulatedHashes
    }
    
    func testLayerShadowEquatable() {
        let shadow = LayerShadow(opacity: 0.2, radius: 0.2, offset: .zero, color: nil, path: nil)
        let path = CGPath(rect: .zero, transform: nil)
        XCTAssertEqual(shadow, shadow)
        XCTAssertEqual(shadow.hashValue, shadow.hashValue)
        XCTAssertNotEqual(LayerShadow(opacity: 0.2, radius: 0.2, offset: .zero, color: .red, path: path).hashValue, shadow.hashValue)
    }
    
    func testAnyStyleSideEffect() {
        let layer = CALayer()
        let path = CGPath(rect: .zero, transform: nil)
        
        AnyStyle<CALayer>.shadow(opacity: 0.2, radius: 5, offset: CGSize(width: 5, height: 5), color: .red, path: path).sideEffect(on: layer)
        XCTAssertEqual(layer.shadowOpacity, 0.2)
        XCTAssertEqual(layer.shadowOffset, CGSize(width: 5, height: 5))
        XCTAssertEqual(layer.shadowColor, UIColor.red.cgColor)
        XCTAssertEqual(layer.shadowPath, path)
        
        let view = UIView()
        
        AnyStyle<UIView>.shadow(opacity: 0.2, radius: 5, offset: CGSize(width: 5, height: 5), color: .red, path: path).sideEffect(on: view)
        XCTAssertEqual(view.layer.shadowOpacity, 0.2)
        XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 5, height: 5))
        XCTAssertEqual(view.layer.shadowColor, UIColor.red.cgColor)
        XCTAssertEqual(view.layer.shadowPath, path)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
