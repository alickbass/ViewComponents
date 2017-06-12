//
//  CALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public extension CALayer {
    public enum ShadowStyle<T: CALayer>: KeyedStyle {
        public enum Key: Int, Hashable {
            case opacity = 24, radius, offset, color, path
        }
        
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
