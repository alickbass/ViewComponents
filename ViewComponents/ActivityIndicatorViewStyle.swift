//
//  ActivityIndicatorViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum ActivityIndicatorViewStyle: HashableConcreteStyle {
    case isAnimating(Bool)
    case hidesWhenStopped(Bool)
    case activityIndicatorViewStyle(UIActivityIndicatorViewStyle)
    case color(UIColor?)
    
    public func sideEffect(on view: UIActivityIndicatorView) {
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
    
    public static func == (lhs: ActivityIndicatorViewStyle, rhs: ActivityIndicatorViewStyle) -> Bool {
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
    
    @inline(__always) static func startIndex() -> Int {
        return UISliderStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 4
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .isAnimating(value):
            return (1, value.hashValue)
        case let .hidesWhenStopped(value):
            return (2, value.hashValue)
        case let .activityIndicatorViewStyle(value):
            return (3, value.hashValue)
        case let .color(value):
            return (4, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UIActivityIndicatorView {
    public func activityIndicator(_ styles: ActivityIndicatorViewStyle...) -> Component<T> {
        return adding(styles: styles)
    }
}
