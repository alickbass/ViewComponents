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
