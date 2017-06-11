//
//  TestCALayerStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestCALayerStyle: XCTestCase {
    
    static let allStyles: [CALayerStyle<CALayer>] = [
        .contentsGravity(.bottom), CALayerStyle.opacity(0.2), .isHidden(true), .masksToBounds(true),
        .mask(CALayer()), .isDoubleSided(true), .backgroundColor(.red), .allowsEdgeAntialiasing(true),
        .allowsGroupOpacity(true), .isOpaque(true), .edgeAntialiasingMask(.layerLeftEdge), .isGeometryFlipped(true),
        .drawsAsynchronously(true), .shouldRasterize(true), .rasterizationScale(0.2), .contentsFormat(.RGBA16Float),
        .frame(.zero), .bounds(.zero), .position(.zero), .zPosition(12),
        .anchorPoint(.zero), .anchorPointZ(12), .contentsScale(0.2), .name("test"),
        .mask(nil), .backgroundColor(nil), .name(nil)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestCALayerStyle.allStyles.map({ $0.hashValue })
    }
    
    func testCAGravity() {
        XCTAssertEqual(CAGravity.center.rawValue, kCAGravityCenter)
        XCTAssertEqual(CAGravity.top.rawValue, kCAGravityTop)
        XCTAssertEqual(CAGravity.bottom.rawValue, kCAGravityBottom)
        XCTAssertEqual(CAGravity.left.rawValue, kCAGravityLeft)
        XCTAssertEqual(CAGravity.right.rawValue, kCAGravityRight)
        XCTAssertEqual(CAGravity.topLeft.rawValue, kCAGravityTopLeft)
        XCTAssertEqual(CAGravity.topRight.rawValue, kCAGravityTopRight)
        XCTAssertEqual(CAGravity.bottomLeft.rawValue, kCAGravityBottomLeft)
        XCTAssertEqual(CAGravity.bottomRight.rawValue, kCAGravityBottomRight)
        XCTAssertEqual(CAGravity.resize.rawValue, kCAGravityResize)
        XCTAssertEqual(CAGravity.resizeAspect.rawValue, kCAGravityResizeAspect)
        XCTAssertEqual(CAGravity.resizeAspectFill.rawValue, kCAGravityResizeAspectFill)
        
        XCTAssertEqual(CAGravity(rawValue: kCAGravityCenter), .center)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityTop), .top)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityBottom), .bottom)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityLeft), .left)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityRight), .right)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityTopLeft), .topLeft)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityTopRight), .topRight)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityBottomLeft), .bottomLeft)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityBottomRight), .bottomRight)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityResize), .resize)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityResizeAspect), .resizeAspect)
        XCTAssertEqual(CAGravity(rawValue: kCAGravityResizeAspectFill), .resizeAspectFill)
        XCTAssertNil(CAGravity(rawValue: "random"))
    }
    
    func testCAContentsFormat() {
        XCTAssertEqual(CAContentsFormat.RGBA8Uint.rawValue, kCAContentsFormatRGBA8Uint)
        XCTAssertEqual(CAContentsFormat.RGBA16Float.rawValue, kCAContentsFormatRGBA16Float)
        XCTAssertEqual(CAContentsFormat.gray8Uint.rawValue, kCAContentsFormatGray8Uint)
        
        XCTAssertEqual(CAContentsFormat(rawValue: kCAContentsFormatRGBA8Uint), .RGBA8Uint)
        XCTAssertEqual(CAContentsFormat(rawValue: kCAContentsFormatRGBA16Float), .RGBA16Float)
        XCTAssertEqual(CAContentsFormat(rawValue: kCAContentsFormatGray8Uint), .gray8Uint)
        XCTAssertNil(CAContentsFormat(rawValue: "random"))
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(CALayerStyle.contentsGravity(.bottom), .contentsGravity(.bottom))
        XCTAssertEqual(CALayerStyle.opacity(0.2), .opacity(0.2))
        XCTAssertEqual(CALayerStyle.isHidden(true), .isHidden(true))
        XCTAssertEqual(CALayerStyle.masksToBounds(true), .masksToBounds(true))
        let mask = CALayer()
        XCTAssertEqual(CALayerStyle.mask(mask), .mask(mask))
        XCTAssertEqual(CALayerStyle.isDoubleSided(true), .isDoubleSided(true))
        XCTAssertEqual(CALayerStyle.backgroundColor(.red), .backgroundColor(.red))
        XCTAssertEqual(CALayerStyle.allowsEdgeAntialiasing(true), .allowsEdgeAntialiasing(true))
        XCTAssertEqual(CALayerStyle.allowsGroupOpacity(true), .allowsGroupOpacity(true))
        XCTAssertEqual(CALayerStyle.isOpaque(true), .isOpaque(true))
        XCTAssertEqual(CALayerStyle.edgeAntialiasingMask(.layerLeftEdge), .edgeAntialiasingMask(.layerLeftEdge))
        XCTAssertEqual(CALayerStyle.isGeometryFlipped(true), .isGeometryFlipped(true))
        XCTAssertEqual(CALayerStyle.drawsAsynchronously(true), .drawsAsynchronously(true))
        XCTAssertEqual(CALayerStyle.shouldRasterize(true), .shouldRasterize(true))
        XCTAssertEqual(CALayerStyle.rasterizationScale(0.2), .rasterizationScale(0.2))
        XCTAssertEqual(CALayerStyle.contentsFormat(.RGBA16Float), .contentsFormat(.RGBA16Float))
        XCTAssertEqual(CALayerStyle.frame(.zero), .frame(.zero))
        XCTAssertEqual(CALayerStyle.bounds(.zero), .bounds(.zero))
        XCTAssertEqual(CALayerStyle.position(.zero), .position(.zero))
        XCTAssertEqual(CALayerStyle.zPosition(12), .zPosition(12))
        XCTAssertEqual(CALayerStyle.anchorPoint(.zero), .anchorPoint(.zero))
        XCTAssertEqual(CALayerStyle.anchorPointZ(12), .anchorPointZ(12))
        XCTAssertEqual(CALayerStyle.contentsScale(0.2), .contentsScale(0.2))
        XCTAssertEqual(CALayerStyle.name("test"), .name("test"))
        XCTAssertNotEqual(CALayerStyle.name("test"), .contentsScale(0.2))
    }
    
    func testStyleSideEffects() {
        let view = CALayer()
        
        view.contentsGravity = kCAGravityCenter
        CALayerStyle.contentsGravity(.bottom).sideEffect(on: view)
        XCTAssertEqual(view.contentsGravity, kCAGravityBottom)
        
        view.opacity = 1
        CALayerStyle.opacity(0.2).sideEffect(on: view)
        XCTAssertEqual(view.opacity, 0.2)
        
        view.isHidden = false
        CALayerStyle.isHidden(true).sideEffect(on: view)
        XCTAssertEqual(view.isHidden, true)
        
        view.masksToBounds = false
        CALayerStyle.masksToBounds(true).sideEffect(on: view)
        XCTAssertEqual(view.masksToBounds, true)
        
        let mask = CALayer()
        view.mask = mask
        CALayerStyle.mask(mask).sideEffect(on: view)
        XCTAssertEqual(view.mask, mask)
        
        view.isDoubleSided = false
        CALayerStyle.isDoubleSided(true).sideEffect(on: view)
        XCTAssertEqual(view.isDoubleSided, true)
        
        view.backgroundColor = UIColor.red.cgColor
        CALayerStyle.backgroundColor(.green).sideEffect(on: view)
        XCTAssertEqual(view.backgroundColor, UIColor.green.cgColor)
        
        view.allowsEdgeAntialiasing = false
        CALayerStyle.allowsEdgeAntialiasing(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsEdgeAntialiasing, true)
        
        view.allowsGroupOpacity = false
        CALayerStyle.allowsGroupOpacity(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsGroupOpacity, true)
        
        view.isOpaque = false
        CALayerStyle.isOpaque(true).sideEffect(on: view)
        XCTAssertEqual(view.isOpaque, true)
        
        view.edgeAntialiasingMask = .layerTopEdge
        CALayerStyle.edgeAntialiasingMask(.layerLeftEdge).sideEffect(on: view)
        XCTAssertEqual(view.edgeAntialiasingMask, .layerLeftEdge)
        
        view.isGeometryFlipped = false
        CALayerStyle.isGeometryFlipped(true).sideEffect(on: view)
        XCTAssertEqual(view.isGeometryFlipped, true)
        
        view.drawsAsynchronously = false
        CALayerStyle.drawsAsynchronously(true).sideEffect(on: view)
        XCTAssertEqual(view.drawsAsynchronously, true)
        
        view.shouldRasterize = false
        CALayerStyle.shouldRasterize(true).sideEffect(on: view)
        XCTAssertEqual(view.shouldRasterize, true)
        
        view.rasterizationScale = 1
        CALayerStyle.rasterizationScale(0.2).sideEffect(on: view)
        XCTAssertEqual(view.rasterizationScale, 0.2)
        
        view.contentsFormat = kCAContentsFormatRGBA16Float
        CALayerStyle.contentsFormat(.RGBA8Uint).sideEffect(on: view)
        XCTAssertEqual(view.contentsFormat, kCAContentsFormatRGBA8Uint)
        
        view.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        CALayerStyle.frame(.zero).sideEffect(on: view)
        XCTAssertEqual(view.frame, .zero)
        
        view.bounds = CGRect(x: 20, y: 20, width: 20, height: 20)
        CALayerStyle.bounds(.zero).sideEffect(on: view)
        XCTAssertEqual(view.bounds, .zero)
        
        view.position = CGPoint(x: 20, y: 20)
        CALayerStyle.position(.zero).sideEffect(on: view)
        XCTAssertEqual(view.position, .zero)
        
        view.zPosition = 1
        CALayerStyle.zPosition(0.2).sideEffect(on: view)
        XCTAssertEqual(view.zPosition, 0.2)
        
        view.anchorPointZ = 1
        CALayerStyle.anchorPointZ(0.2).sideEffect(on: view)
        XCTAssertEqual(view.anchorPointZ, 0.2)
        
        view.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        CALayerStyle.anchorPoint(.zero).sideEffect(on: view)
        XCTAssertEqual(view.anchorPoint, .zero)
        
        view.contentsScale = 1
        CALayerStyle.contentsScale(0.2).sideEffect(on: view)
        XCTAssertEqual(view.contentsScale, 0.2)
        
        view.name = nil
        CALayerStyle.name("test").sideEffect(on: view)
        XCTAssertEqual(view.name, "test")
        
        view.name = nil
        Component<CALayer>().layer(.name("test")).configure(item: view)
        XCTAssertEqual(view.name, "test")
        
        let theView = UIView()
        theView.layer.name = nil
        Component<UIView>().layer(.name("test")).configure(item: theView)
        XCTAssertEqual(theView.layer.name, "test")
    }
    
    func testHashValue() {
        var hashes = Set<Int>()
        
        for item in TestCALayerStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
