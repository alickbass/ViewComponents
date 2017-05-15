//
//  UISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UISwitchStyle: HashableConcreteStyle {
    case isOn(Bool, animated: Bool)
    case onTintColor(UIColor?)
    case thumbTintColor(UIColor?)
    case onImage(UIImage?)
    case offImage(UIImage?)

    public func sideEffect(on view: UISwitch) {
        switch self {
        case let .isOn(value, animated: animated):
            view.setOn(value, animated: animated)
        case let .onTintColor(value):
            view.onTintColor = value
        case let .thumbTintColor(value):
            view.thumbTintColor = value
        case let .onImage(value):
            view.onImage = value
        case let .offImage(value):
            view.offImage = value
        }
    }
    
    public static func == (lhs: UISwitchStyle, rhs: UISwitchStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.isOn(left, animated: leftAnimated), .isOn(right, animated: rightAnimated)):
            return left == right && leftAnimated == rightAnimated
        case let (.onTintColor(left), .onTintColor(right)),
             let (.thumbTintColor(left), .thumbTintColor(right)):
            return left == right
        case let (.onImage(left), .onImage(right)),
             let (.offImage(left), .offImage(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return ActivityIndicatorViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 5
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .isOn(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (1, hash)
        case let .onTintColor(value):
            return (2, value?.hashValue ?? 0)
        case let .thumbTintColor(value):
            return (3, value?.hashValue ?? 0)
        case let .onImage(value):
            return (4, value?.hashValue ?? 0)
        case let .offImage(value):
            return (5, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UISwitch {
    public func switchStyles(_ styles: UISwitchStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
