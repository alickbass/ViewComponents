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
        XCTAssertEqual(CALayerStyle.contentsScale(0.2), .contentsScale(0.2))
        XCTAssertEqual(CALayerStyle.name("test"), .name("test"))
        XCTAssertNotEqual(CALayerStyle.name("test"), .contentsScale(0.2))
    }
}
