//
//  CALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum CALayerShadowStyleKey: Int, Hashable {
    case opacity = 24, radius, offset, color, path, shadow
}

public extension CALayer {
    public enum ShadowStyle<T: CALayer>: KeyedStyle {
        public typealias Key = CALayerShadowStyleKey
        
        case opacity(Float)
        case radius(CGFloat)
        case offset(CGSize)
        case color(UIColor?)
        case path(CGPath?)
        
        public func sideEffect(on layer: T) {
            switch self {
            case let .opacity(shadowOpacity):
                layer.shadowOpacity = shadowOpacity
            case let .radius(shadowRadius):
                layer.shadowRadius = shadowRadius
            case let .offset(shadowOffset):
                layer.shadowOffset = shadowOffset
            case let .color(shadowColor):
                layer.shadowColor = shadowColor?.cgColor
            case let .path(shadowPath):
                layer.shadowPath = shadowPath
            }
        }
        
        public static func == (lhs: ShadowStyle<T>, rhs: ShadowStyle<T>) -> Bool {
            switch (lhs, rhs) {
            case let (.opacity(leftOpacity), .opacity(rightOpacity)):
                return leftOpacity == rightOpacity
            case let (.radius(leftRadius), .radius(rightRadius)):
                return leftRadius == rightRadius
            case let (.offset(leftOffset), .offset(rightOffset)):
                return leftOffset == rightOffset
            case let (.color(leftColor), .color(rightColor)):
                return leftColor == rightColor
            case let (.path(leftPath), .path(rightPath)):
                return leftPath == rightPath
            default:
                return false
            }
        }
        
        @inline(__always) public func value() -> (key: Key, valueHash: Int) {
            switch self {
            case let .opacity(shadowOpacity):
                return (.opacity, shadowOpacity.hashValue)
            case let .radius(shadowRadius):
                return (.radius, shadowRadius.hashValue)
            case let .offset(shadowOffset):
                return (.offset, shadowOffset.hashValue)
            case let .color(shadowColor):
                return (.color, shadowColor?.hashValue ?? 0)
            case let .path(shadowPath):
                return (.path, shadowPath.map({ UIBezierPath(cgPath: $0) })?.hashValue ?? 0)
            }
        }
    }
}

public extension Component where T: UIView {
    public func shadow(_ styles: CALayer.ShadowStyle...) -> Component<T> {
        return withChildren(.child({ $0.layer }, Component<CALayer>().adding(styles: styles.lazy.map(AnyStyle<CALayer>.init))))
    }
}

public extension Component where T: CALayer {
    public func shadow(_ styles: CALayer.ShadowStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}

struct LayerShadow: Hashable, StyleType {
    let opacity: Float
    let radius: CGFloat
    let offset: CGSize
    let color: UIColor?
    let path: CGPath?
    
    func sideEffect(on layer: CALayer) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color?.cgColor
        layer.shadowPath = path
    }
    
    static func == (lhs: LayerShadow, rhs: LayerShadow) -> Bool {
        return lhs.opacity == rhs.opacity
            && lhs.radius == rhs.radius
            && lhs.offset == rhs.offset
            && lhs.color == rhs.color
            && lhs.path == rhs.path
    }
    
    var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ opacity.hashValue
        hash = ((hash << 5) &+ hash) &+ radius.hashValue
        hash = ((hash << 5) &+ hash) &+ offset.hashValue
        hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
        hash = ((hash << 5) &+ hash) &+ (path.map({ UIBezierPath(cgPath: $0) })?.hashValue ?? 0)
        return hash
    }
}

public extension AnyStyle where T: CALayer {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerShadowStyleKey>
    
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = UIColor.black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return ViewStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0) }).toAnyStyle
    }
}

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerShadowStyleKey>
    
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = UIColor.black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return ViewStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0.layer) }).toAnyStyle
    }
}
