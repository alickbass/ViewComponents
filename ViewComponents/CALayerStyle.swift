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

public enum CALayerStyle: ConcreteStyleType {
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
        switch self {
        case let .contentsGravity(gravity):
            view.layer.contentsGravity = gravity.rawValue
        case let .opacity(opacity):
            view.layer.opacity = opacity
        case let .isHidden(isHidden):
            view.layer.isHidden = isHidden
        case let .masksToBounds(masksToBounds):
            view.layer.masksToBounds = masksToBounds
        case let .mask(mask):
            view.layer.mask = mask
        case let .isDoubleSided(isDoubleSided):
            view.layer.isDoubleSided = isDoubleSided
        case let .backgroundColor(backgroundColor):
            view.layer.backgroundColor = backgroundColor?.cgColor
        case let .allowsEdgeAntialiasing(allowsEdgeAntialiasing):
            view.layer.allowsEdgeAntialiasing = allowsEdgeAntialiasing
        case let .allowsGroupOpacity(allowsGroupOpacity):
            view.layer.allowsGroupOpacity = allowsGroupOpacity
        case let .isOpaque(isOpaque):
            view.layer.isOpaque = isOpaque
        case let .edgeAntialiasingMask(edgeAntialiasingMask):
            view.layer.edgeAntialiasingMask = edgeAntialiasingMask
        case let .isGeometryFlipped(isGeometryFlipped):
            view.layer.isGeometryFlipped = isGeometryFlipped
        case let .drawsAsynchronously(drawsAsynchronously):
            view.layer.drawsAsynchronously = drawsAsynchronously
        case let .shouldRasterize(shouldRasterize):
            view.layer.shouldRasterize = shouldRasterize
        case let .rasterizationScale(rasterizationScale):
            view.layer.rasterizationScale = rasterizationScale
        case let .contentsFormat(contentsFormat):
            view.layer.contentsFormat = contentsFormat.rawValue
        case let .frame(frame):
            view.layer.frame = frame
        case let .bounds(bounds):
            view.layer.bounds = bounds
        case let .position(position):
            view.layer.position = position
        case let .zPosition(zPosition):
            view.layer.zPosition = zPosition
        case let .anchorPointZ(anchorPointZ):
            view.layer.anchorPointZ = anchorPointZ
        case let .anchorPoint(anchorPoint):
            view.layer.anchorPoint = anchorPoint
        case let .contentsScale(contentsScale):
            view.layer.contentsScale = contentsScale
        case let .name(name):
            view.layer.name = name
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
}
