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

enum CALayerStyleKey: Int, Hashable {
    case contentsGravity = 0, opacity, isHidden
    case masksToBounds, mask, isDoubleSided
    case backgroundColor, allowsEdgeAntialiasing, allowsGroupOpacity
    case isOpaque, edgeAntialiasingMask, isGeometryFlipped
    case drawsAsynchronously, shouldRasterize, rasterizationScale
    case contentsFormat, frame, bounds
    case position, zPosition, anchorPointZ
    case anchorPoint, contentsScale, name
    case shadow, border
}

public extension AnyStyle where T: CALayer {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    public static func contentsGravity(_ gravity: CAGravity) -> AnyStyle<T> {
        return ViewStyle(gravity, key: .contentsGravity, sideEffect: { $0.contentsGravity = $1.rawValue }).toAnyStyle
    }
    
    public static func opacity(_ opacity: Float) -> AnyStyle<T> {
        return ViewStyle(opacity, key: .opacity, sideEffect: { $0.opacity = $1 }).toAnyStyle
    }
    
    public static func isHidden(_ isHidden: Bool) -> AnyStyle<T> {
        return ViewStyle(isHidden, key: .isHidden, sideEffect: { $0.isHidden = $1 }).toAnyStyle
    }
    
    public static func masksToBounds(_ masksToBounds: Bool) -> AnyStyle<T> {
        return ViewStyle(masksToBounds, key: .masksToBounds, sideEffect: { $0.masksToBounds = $1 }).toAnyStyle
    }
    
    public static func mask(_ mask: CALayer?) -> AnyStyle<T> {
        return ViewStyle(mask, key: .mask, sideEffect: { $0.mask = $1 }).toAnyStyle
    }
    
    public static func isDoubleSided(_ isDoubleSided: Bool) -> AnyStyle<T> {
        return ViewStyle(isDoubleSided, key: .isDoubleSided, sideEffect: { $0.isDoubleSided = $1 }).toAnyStyle
    }
    
    public static func backgroundColor(_ color: UIColor?) -> AnyStyle<T> {
        return ViewStyle(color, key: .backgroundColor, sideEffect: { $0.backgroundColor = $1?.cgColor }).toAnyStyle
    }
    
    public static func allowsEdgeAntialiasing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsEdgeAntialiasing, sideEffect: { $0.allowsEdgeAntialiasing = $1 }).toAnyStyle
    }
    
    public static func allowsGroupOpacity(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsGroupOpacity, sideEffect: { $0.allowsGroupOpacity = $1 }).toAnyStyle
    }
    
    public static func isOpaque(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isOpaque, sideEffect: { $0.isOpaque = $1 }).toAnyStyle
    }
    
    public static func edgeAntialiasingMask(_ mask: CAEdgeAntialiasingMask) -> AnyStyle<T> {
        return ViewStyle(mask, key: .edgeAntialiasingMask, sideEffect: { $0.edgeAntialiasingMask = $1 }).toAnyStyle
    }
    
    public static func isGeometryFlipped(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isGeometryFlipped, sideEffect: { $0.isGeometryFlipped = $1 }).toAnyStyle
    }
    
    public static func drawsAsynchronously(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .drawsAsynchronously, sideEffect: { $0.drawsAsynchronously = $1 }).toAnyStyle
    }
    
    public static func shouldRasterize(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .shouldRasterize, sideEffect: { $0.shouldRasterize = $1 }).toAnyStyle
    }
    
    public static func rasterizationScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .rasterizationScale, sideEffect: { $0.rasterizationScale = $1 }).toAnyStyle
    }
    
    @available(iOS 10.0, *)
    public static func contentsFormat(_ value: CAContentsFormat) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentsFormat, sideEffect: { $0.contentsFormat = $1.rawValue }).toAnyStyle
    }
    
    public static func frame(_ value: CGRect) -> AnyStyle<T> {
        return ViewStyle(value, key: .frame, sideEffect: { $0.frame = $1 }).toAnyStyle
    }
    
    public static func bounds(_ value: CGRect) -> AnyStyle<T> {
        return ViewStyle(value, key: .bounds, sideEffect: { $0.bounds = $1 }).toAnyStyle
    }
    
    public static func position(_ value: CGPoint) -> AnyStyle<T> {
        return ViewStyle(value, key: .position, sideEffect: { $0.position = $1 }).toAnyStyle
    }
    
    public static func zPosition(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .zPosition, sideEffect: { $0.zPosition = $1 }).toAnyStyle
    }
    
    public static func anchorPointZ(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .anchorPointZ, sideEffect: { $0.anchorPointZ = $1 }).toAnyStyle
    }
    
    public static func anchorPoint(_ value: CGPoint) -> AnyStyle<T> {
        return ViewStyle(value, key: .anchorPoint, sideEffect: { $0.anchorPoint = $1 }).toAnyStyle
    }
    
    public static func contentsScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentsScale, sideEffect: { $0.contentsScale = $1 }).toAnyStyle
    }
    
    public static func name(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .name, sideEffect: { $0.name = $1 }).toAnyStyle
    }
}
