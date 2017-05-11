//
//  CALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public extension CALayer {
    public enum BorderStyle: ConcreteStyleType {
        case cornerRadius(CGFloat)
        case width(CGFloat)
        case color(UIColor?)
        
        public func sideEffect(on view: UIView) {
            switch self {
            case let .cornerRadius(cornerRadius):
                view.layer.cornerRadius = cornerRadius
            case let .width(borderWidth):
                view.layer.borderWidth = borderWidth
            case let .color(borderColor):
                view.layer.borderColor = borderColor?.cgColor
            }
        }
        
        public static func == (lhs: BorderStyle, rhs: BorderStyle) -> Bool {
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
    }
}

public extension Component {
    public func borderStyles(_ styles: CALayer.BorderStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
