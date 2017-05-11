//
//  CALayerStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum CAGravity: RawRepresentable {
    case center, top, bottom, left, right
    case topLeft, topRight
    case bottomLeft, bottomRight
    case resize, resizeAspect, resizeAspectFill
    
    public var rawValue: String {
        switch self {
        case .center: return kCAGravityCenter
        case .top: return kCAGravityTop
        case .bottom: return kCAGravityBottom
        case .left: return kCAGravityLeft
        case .right: return kCAGravityRight
        case .topLeft: return kCAGravityTopLeft
        case .topRight: return kCAGravityTopRight
        case .bottomLeft: return kCAGravityBottomLeft
        case .bottomRight: return kCAGravityBottomRight
        case .resize: return kCAGravityResize
        case .resizeAspect: return kCAGravityResizeAspect
        case .resizeAspectFill: return kCAGravityResizeAspectFill
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case kCAGravityCenter: self = .center
        case kCAGravityTop: self = .top
        case kCAGravityBottom: self = .bottom
        case kCAGravityLeft: self = .left
        case kCAGravityRight: self = .right
        case kCAGravityTopLeft: self = .topLeft
        case kCAGravityTopRight: self = .topRight
        case kCAGravityBottomLeft: self = .bottomLeft
        case kCAGravityBottomRight: self = .bottomRight
        case kCAGravityResize: self = .resize
        case kCAGravityResizeAspect: self = .resizeAspect
        case kCAGravityResizeAspectFill: self = .resizeAspectFill
        default: return nil
        }
    }
}

public enum CAContentsFormat: RawRepresentable {
    case RGBA8Uint, RGBA16Float, gray8Uint
    
    public var rawValue: String {
        switch self {
        case .RGBA8Uint: return kCAContentsFormatRGBA8Uint
        case .RGBA16Float: return kCAContentsFormatRGBA16Float
        case .gray8Uint: return kCAContentsFormatGray8Uint
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case kCAContentsFormatRGBA8Uint: self = .RGBA8Uint
        case kCAContentsFormatRGBA16Float: self = .RGBA16Float
        case kCAContentsFormatGray8Uint: self = .gray8Uint
        default: return nil
        }
    }
}

public enum CALayerStyle: ConcreteStyleType, HashableStyle {
    case contentsGravity(CAGravity)
    case opacity(Float)
    case isHidden(Bool)
    case masksToBounds(Bool)
    case mask(CALayer?)
    case isDoubleSided(Bool)
    case backgroundColor(UIColor?)
    case allowsEdgeAntialiasing(Bool)
    case allowsGroupOpacity(Bool)
    case isOpaque(Bool)
    case edgeAntialiasingMask(CAEdgeAntialiasingMask)
    case isGeometryFlipped(Bool)
    case drawsAsynchronously(Bool)
    case shouldRasterize(Bool)
    case rasterizationScale(CGFloat)
    case contentsFormat(CAContentsFormat)
    case frame(CGRect)
    case bounds(CGRect)
    case position(CGPoint)
    case zPosition(CGFloat)
    case anchorPointZ(CGFloat)
    case anchorPoint(CGPoint)
    case contentsScale(CGFloat)
    case name(String?)
    
    public func sideEffect(on view: UIView) {
        let layer = view.layer
        switch self {
        case let .contentsGravity(gravity):
            layer.contentsGravity = gravity.rawValue
        case let .opacity(opacity):
            layer.opacity = opacity
        case let .isHidden(isHidden):
            layer.isHidden = isHidden
        case let .masksToBounds(masksToBounds):
            layer.masksToBounds = masksToBounds
        case let .mask(mask):
            layer.mask = mask
        case let .isDoubleSided(isDoubleSided):
            layer.isDoubleSided = isDoubleSided
        case let .backgroundColor(backgroundColor):
            layer.backgroundColor = backgroundColor?.cgColor
        case let .allowsEdgeAntialiasing(allowsEdgeAntialiasing):
            layer.allowsEdgeAntialiasing = allowsEdgeAntialiasing
        case let .allowsGroupOpacity(allowsGroupOpacity):
            layer.allowsGroupOpacity = allowsGroupOpacity
        case let .isOpaque(isOpaque):
            layer.isOpaque = isOpaque
        case let .edgeAntialiasingMask(edgeAntialiasingMask):
            layer.edgeAntialiasingMask = edgeAntialiasingMask
        case let .isGeometryFlipped(isGeometryFlipped):
            layer.isGeometryFlipped = isGeometryFlipped
        case let .drawsAsynchronously(drawsAsynchronously):
            layer.drawsAsynchronously = drawsAsynchronously
        case let .shouldRasterize(shouldRasterize):
            layer.shouldRasterize = shouldRasterize
        case let .rasterizationScale(rasterizationScale):
            layer.rasterizationScale = rasterizationScale
        case let .contentsFormat(contentsFormat):
            layer.contentsFormat = contentsFormat.rawValue
        case let .frame(frame):
            layer.frame = frame
        case let .bounds(bounds):
            layer.bounds = bounds
        case let .position(position):
            layer.position = position
        case let .zPosition(zPosition):
            layer.zPosition = zPosition
        case let .anchorPointZ(anchorPointZ):
            layer.anchorPointZ = anchorPointZ
        case let .anchorPoint(anchorPoint):
            layer.anchorPoint = anchorPoint
        case let .contentsScale(contentsScale):
            layer.contentsScale = contentsScale
        case let .name(name):
            layer.name = name
        }
    }
    
    public static func == (lhs: CALayerStyle, rhs: CALayerStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.contentsGravity(left), .contentsGravity(right)):
            return left == right
        case let (.opacity(left), .opacity(right)):
            return left == right
        case let (.isHidden(left), .isHidden(right)),
             let (.masksToBounds(left), .masksToBounds(right)),
             let (.isDoubleSided(left), .isDoubleSided(right)),
             let (.allowsEdgeAntialiasing(left), .allowsEdgeAntialiasing(right)),
             let (.allowsGroupOpacity(left), .allowsGroupOpacity(right)),
             let (.isOpaque(left), .isOpaque(right)),
             let (.isGeometryFlipped(left), .isGeometryFlipped(right)),
             let (.drawsAsynchronously(left), .drawsAsynchronously(right)),
             let (.shouldRasterize(left), .shouldRasterize(right)):
            return left == right
        case let (.mask(left), .mask(right)):
            return left == right
        case let (.backgroundColor(left), .backgroundColor(right)):
            return left == right
        case let (.edgeAntialiasingMask(left), .edgeAntialiasingMask(right)):
            return left == right
        case let (.rasterizationScale(left), .rasterizationScale(right)),
             let (.zPosition(left), .zPosition(right)),
             let (.anchorPointZ(left), .anchorPointZ(right)),
             let (.contentsScale(left), .contentsScale(right)):
            return left == right
        case let (.contentsFormat(left), .contentsFormat(right)):
            return left == right
        case let (.frame(left), .frame(right)),
             let (.bounds(left), .bounds(right)):
            return left == right
        case let (.position(left), .position(right)),
             let (.anchorPoint(left), .anchorPoint(right)):
            return left == right
        case let (.name(left), .name(right)):
            return left == right
        default:
            return false
        }
    }
    
    var startIndex: Int {
        return 0
    }
    
    var value: (index: Int, valueHash: Int) {
        switch self {
        case let .contentsGravity(gravity):
            return (1, gravity.hashValue)
        case let .opacity(opacity):
            return (2, opacity.hashValue)
        case let .isHidden(isHidden):
            return (3, isHidden.hashValue)
        case let .masksToBounds(masksToBounds):
            return (4, masksToBounds.hashValue)
        case let .mask(mask):
            return (5, mask?.hashValue ?? 1)
        case let .isDoubleSided(isDoubleSided):
            return (6, isDoubleSided.hashValue)
        case let .backgroundColor(backgroundColor):
            return (7, backgroundColor?.hashValue ?? 1)
        case let .allowsEdgeAntialiasing(allowsEdgeAntialiasing):
            return (8, allowsEdgeAntialiasing.hashValue)
        case let .allowsGroupOpacity(allowsGroupOpacity):
            return (9, allowsGroupOpacity.hashValue)
        case let .isOpaque(isOpaque):
            return (10, isOpaque.hashValue)
        case let .edgeAntialiasingMask(edgeAntialiasingMask):
            return (11, edgeAntialiasingMask.rawValue.hashValue)
        case let .isGeometryFlipped(isGeometryFlipped):
            return (12, isGeometryFlipped.hashValue)
        case let .drawsAsynchronously(drawsAsynchronously):
            return (13, drawsAsynchronously.hashValue)
        case let .shouldRasterize(shouldRasterize):
            return (14, shouldRasterize.hashValue)
        case let .rasterizationScale(rasterizationScale):
            return (15, rasterizationScale.hashValue)
        case let .contentsFormat(contentsFormat):
            return (16, contentsFormat.hashValue)
        case let .frame(frame):
            return (17, frame.hashValue)
        case let .bounds(bounds):
            return (18, bounds.hashValue)
        case let .position(position):
            return (19, position.hashValue)
        case let .zPosition(zPosition):
            return (20, zPosition.hashValue)
        case let .anchorPointZ(anchorPointZ):
            return (21, anchorPointZ.hashValue)
        case let .anchorPoint(anchorPoint):
            return (22, anchorPoint.hashValue)
        case let .contentsScale(contentsScale):
            return (23, contentsScale.hashValue)
        case let .name(name):
            return (24, name?.hashValue ?? 1)
        }
    }
}

public extension Component {
    public func layerStyles(_ styles: CALayerStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
