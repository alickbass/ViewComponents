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
        testAccumulatingHashes()
    }
}
