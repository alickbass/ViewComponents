//
//  TestCALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 10/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
@testable import ViewComponents

class TestCALayerBorderStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIView>] = [
        .border(cornerRadius: 12, width: 12, color: nil),
        .border(cornerRadius: 12, width: 12, color: .red)
    ]
    
    static var previousHashes: [Int : Any] { return TestCALayerShadowStyle.accumulatedHashes }
    
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
    
    func testLayerBorderHashable() {
        let border = LayerBorder(cornerRadius: 12, width: 12, color: nil)
        XCTAssertEqual(border, border)
        XCTAssertEqual(border.hashValue, border.hashValue)
        XCTAssertNotEqual(LayerBorder(cornerRadius: 12, width: 12, color: .red).hashValue, border.hashValue)
    }
    
    func testAnyStyleSideEffects() {
        let view = UIView()
        
        AnyStyle<UIView>.border(cornerRadius: 12, width: 12, color: .red).sideEffect(on: view)
        XCTAssertEqual(view.layer.cornerRadius, 12)
        XCTAssertEqual(view.layer.borderWidth, 12)
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
        
        let layer = CALayer()
        
        AnyStyle<CALayer>.border(cornerRadius: 12, width: 12, color: .red).sideEffect(on: layer)
        XCTAssertEqual(layer.cornerRadius, 12)
        XCTAssertEqual(layer.borderWidth, 12)
        XCTAssertEqual(layer.borderColor, UIColor.red.cgColor)
    }
    
    func testHashValue() {
        XCTAssertEqual(CALayer.BorderStyle.Key.cornerRadius.rawValue, CALayer.ShadowStyle.Key.path.rawValue + 1)
        testAccumulatingHashes()
    }
}
