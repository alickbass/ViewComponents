//
//  ActivityIndicatorViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum ActivityIndicatorViewStyle<T: UIActivityIndicatorView>: KeyedStyle {
    public enum Key: Int, Hashable {
        case isAnimating = 201, hidesWhenStopped, activityIndicatorViewStyle, color
    }
    
    case isAnimating(Bool)
    case hidesWhenStopped(Bool)
    case activityIndicatorViewStyle(UIActivityIndicatorViewStyle)
    case color(UIColor?)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .isAnimating(value):
            switch value {
            case true:
                view.startAnimating()
            case false:
                view.stopAnimating()
            }
        case let .hidesWhenStopped(value):
            view.hidesWhenStopped = value
        case let .activityIndicatorViewStyle(value):
            view.activityIndicatorViewStyle = value
        case let .color(value):
            view.color = value
        }
    }
    
    public static func == (lhs: ActivityIndicatorViewStyle<T>, rhs: ActivityIndicatorViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.isAnimating(left), .isAnimating(right)),
             let (.hidesWhenStopped(left), .hidesWhenStopped(right)):
            return left == right
        case let (.activityIndicatorViewStyle(left), .activityIndicatorViewStyle(right)):
            return left == right
        case let (.color(left), .color(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .isAnimating(value):
            return (.isAnimating, value.hashValue)
        case let .hidesWhenStopped(value):
            return (.hidesWhenStopped, value.hashValue)
        case let .activityIndicatorViewStyle(value):
            return (.activityIndicatorViewStyle, value.hashValue)
        case let .color(value):
            return (.color, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UIActivityIndicatorView {
    public func activityIndicator(_ styles: ActivityIndicatorViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
