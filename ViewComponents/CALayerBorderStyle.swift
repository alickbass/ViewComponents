//
//  CALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public extension CALayer {
    public enum BorderStyle<T: UIView>: HashableConcreteStyle {
        case cornerRadius(CGFloat)
        case width(CGFloat)
        case color(UIColor?)
        
        public func sideEffect(on view: T) {
            let layer = view.layer
            switch self {
            case let .cornerRadius(cornerRadius):
                layer.cornerRadius = cornerRadius
            case let .width(borderWidth):
                layer.borderWidth = borderWidth
            case let .color(borderColor):
                layer.borderColor = borderColor?.cgColor
            }
        }
        
        public static func == (lhs: BorderStyle<T>, rhs: BorderStyle<T>) -> Bool {
            switch (lhs, rhs) {
            case let (.cornerRadius(leftRaduis), .cornerRadius(rightRaduis)):
                return leftRaduis == rightRaduis
            case let (.width(leftWidth), .width(rightWidth)):
                return leftWidth == rightWidth
            case let (.color(leftColor), .color(rightColor)):
                return leftColor == rightColor
            default:
                return false
            }
        }
        
        @inline(__always) static func startIndex() -> Int {
            return CALayer.ShadowStyle.lastStyleIndex()
        }
        
        @inline(__always) static func stylesCount() -> Int {
            return 3
        }
        
        @inline(__always) func value() -> (index: Int, valueHash: Int) {
            switch self {
            case let .cornerRadius(cornerRadius):
                return (1, cornerRadius.hashValue)
            case let .width(borderWidth):
                return (2, borderWidth.hashValue)
            case let .color(borderColor):
                return (3, borderColor?.hashValue ?? 0)
            }
        }
    }
}

public extension Component where T: UIView {
    public func border(_ styles: CALayer.BorderStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
