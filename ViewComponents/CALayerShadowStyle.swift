//
//  CALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public extension CALayer {
    public enum ShadowStyle: ConcreteStyleType {
        case opacity(Float)
        case radius(CGFloat)
        case offset(CGSize)
        case color(UIColor?)
        case path(CGPath?)
        
        public func sideEffect(on view: UIView) {
            switch self {
            case let .opacity(shadowOpacity):
                view.layer.shadowOpacity = shadowOpacity
            case let .radius(shadowRadius):
                view.layer.shadowRadius = shadowRadius
            case let .offset(shadowOffset):
                view.layer.shadowOffset = shadowOffset
            case let .color(shadowColor):
                view.layer.shadowColor = shadowColor?.cgColor
            case let .path(shadowPath):
                view.layer.shadowPath = shadowPath
            }
        }
        
        public static func == (lhs: ShadowStyle, rhs: ShadowStyle) -> Bool {
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
    }
}

public extension Component {
    public func layerShadowStyles(_ styles: CALayer.ShadowStyle...) -> Component<T> {
        return Component<T>(styles: self.styles + styles, children: children)
    }
}
