//
//  UISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UISwitchStyle<T: UISwitch>: KeyedStyle {
    public enum Key: Int, Hashable {
        case isOn = 205, onTintColor, thumbTintColor, onImage, offImage
    }
    
    case isOn(Bool, animated: Bool)
    case onTintColor(UIColor?)
    case thumbTintColor(UIColor?)
    case onImage(UIImage?)
    case offImage(UIImage?)

    public func sideEffect(on view: T) {
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
    
    public static func == (lhs: UISwitchStyle<T>, rhs: UISwitchStyle<T>) -> Bool {
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .isOn(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (.isOn, hash)
        case let .onTintColor(value):
            return (.onTintColor, value?.hashValue ?? 0)
        case let .thumbTintColor(value):
            return (.thumbTintColor, value?.hashValue ?? 0)
        case let .onImage(value):
            return (.onImage, value?.hashValue ?? 0)
        case let .offImage(value):
            return (.offImage, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UISwitch {
    public func `switch`(_ styles: UISwitchStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
