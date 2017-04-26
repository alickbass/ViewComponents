//
//  UIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIButtonStyle: ConcreteStyleType {
    case title(String?, for: UIControlState)
    case titleColor(UIColor?, for: UIControlState)
    
    public func sideEffect(on view: UIButton) {
        switch self {
        case let .title(title, for: state):
            view.setTitle(title, for: state)
        case let .titleColor(color, for: state):
            view.setTitleColor(color, for: state)
        }
    }
    
    public static func == (lhs: UIButtonStyle, rhs: UIButtonStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.title(leftTitle, for: leftState), .title(rightTitle, for: rightState)):
            return leftTitle == rightTitle && leftState == rightState
        case let (.titleColor(leftColor, for: leftState), .titleColor(rightColor, for: rightState)):
            return leftColor == rightColor && leftState == rightState
        default:
            return false
        }
    }
}

public extension Component where T: UIButton {
    public func buttonStyles(_ styles: UIButtonStyle...) -> Component<T> {
        return Component<T>(styles: self.styles + styles, children: children)
    }
}
