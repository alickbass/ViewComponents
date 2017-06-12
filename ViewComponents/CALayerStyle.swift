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

@available(iOS 10.0, *)
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

public enum CALayerStyleKey: Int, Hashable {
    case contentsGravity = 0, opacity, isHidden
    case masksToBounds, mask, isDoubleSided
    case backgroundColor, allowsEdgeAntialiasing, allowsGroupOpacity
    case isOpaque, edgeAntialiasingMask, isGeometryFlipped
    case drawsAsynchronously, shouldRasterize, rasterizationScale
    case contentsFormat, frame, bounds
    case position, zPosition, anchorPointZ
    case anchorPoint, contentsScale, name
}

public enum CALayerStyle<T: CALayer>: KeyedStyle {
    public typealias Key = CALayerStyleKey
    
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
    @available(iOS 10.0, *)
    case contentsFormat(CAContentsFormat)
    case frame(CGRect)
    case bounds(CGRect)
    case position(CGPoint)
    case zPosition(CGFloat)
    case anchorPointZ(CGFloat)
    case anchorPoint(CGPoint)
    case contentsScale(CGFloat)
    case name(String?)
    
    public func sideEffect(on layer: T) {
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
            if #available(iOSApplicationExtension 10.0, *) {
                layer.contentsFormat = contentsFormat.rawValue
            }
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
    
    public static func == (lhs: CALayerStyle<T>, rhs: CALayerStyle<T>) -> Bool {
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .contentsGravity(gravity):
            return (.contentsGravity, gravity.hashValue)
        case let .opacity(opacity):
            return (.opacity, opacity.hashValue)
        case let .isHidden(isHidden):
            return (.isHidden, isHidden.hashValue)
        case let .masksToBounds(masksToBounds):
            return (.masksToBounds, masksToBounds.hashValue)
        case let .mask(mask):
            return (.mask, mask?.hashValue ?? 1)
        case let .isDoubleSided(isDoubleSided):
            return (.isDoubleSided, isDoubleSided.hashValue)
        case let .backgroundColor(backgroundColor):
            return (.backgroundColor, backgroundColor?.hashValue ?? 1)
        case let .allowsEdgeAntialiasing(allowsEdgeAntialiasing):
            return (.allowsEdgeAntialiasing, allowsEdgeAntialiasing.hashValue)
        case let .allowsGroupOpacity(allowsGroupOpacity):
            return (.allowsGroupOpacity, allowsGroupOpacity.hashValue)
        case let .isOpaque(isOpaque):
            return (.isOpaque, isOpaque.hashValue)
        case let .edgeAntialiasingMask(edgeAntialiasingMask):
            return (.edgeAntialiasingMask, edgeAntialiasingMask.rawValue.hashValue)
        case let .isGeometryFlipped(isGeometryFlipped):
            return (.isGeometryFlipped, isGeometryFlipped.hashValue)
        case let .drawsAsynchronously(drawsAsynchronously):
            return (.drawsAsynchronously, drawsAsynchronously.hashValue)
        case let .shouldRasterize(shouldRasterize):
            return (.shouldRasterize, shouldRasterize.hashValue)
        case let .rasterizationScale(rasterizationScale):
            return (.rasterizationScale, rasterizationScale.hashValue)
        case let .contentsFormat(contentsFormat):
            return (.contentsFormat, contentsFormat.hashValue)
        case let .frame(frame):
            return (.frame, frame.hashValue)
        case let .bounds(bounds):
            return (.bounds, bounds.hashValue)
        case let .position(position):
            return (.position, position.hashValue)
        case let .zPosition(zPosition):
            return (.zPosition, zPosition.hashValue)
        case let .anchorPointZ(anchorPointZ):
            return (.anchorPointZ, anchorPointZ.hashValue)
        case let .anchorPoint(anchorPoint):
            return (.anchorPoint, anchorPoint.hashValue)
        case let .contentsScale(contentsScale):
            return (.contentsScale, contentsScale.hashValue)
        case let .name(name):
            return (.name, name?.hashValue ?? 1)
        }
    }
}

public extension Component where T: UIView {
    public func layer(_ styles: CALayerStyle<CALayer>...) -> Component<T> {
        return withChildren(.child({ $0.layer }, Component<CALayer>().adding(styles: styles.lazy.map(AnyStyle.init))))
    }
}

public extension Component where T: CALayer {
    public func layer(_ styles: CALayerStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
