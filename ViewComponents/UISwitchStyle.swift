//
//  UISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UISwitchStyleKey: Int, Hashable {
    case isOn = 205, onTintColor, thumbTintColor, onImage, offImage
}

public enum UISwitchStyle<T: UISwitch>: KeyedStyle {
    public typealias Key = UISwitchStyleKey
    
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

public extension AnyStyle where T: UISwitch {
    private typealias ViewStyle<Item> = Style<T, Item, UISwitchStyleKey>
    
    public static func isOn(_ value: Bool, animated: Bool) -> AnyStyle<T> {
        return ViewStyle<(Bool, Bool)>(
            (value, animated), key: .isOn,
            sideEffect: { $0.setOn($1.0, animated: $1.1) },
            equality: { $0.0 == $1.0 && $0.1 == $1.1 },
            hash: { value -> Int in
                var hash = 5381
                hash = ((hash << 5) &+ hash) &+ value.0.hashValue
                hash = ((hash << 5) &+ hash) &+ value.1.hashValue
                return hash
            }
        ).toAnyStyle
    }
    
    public static func onTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .onTintColor, sideEffect: { $0.onTintColor = $1 }).toAnyStyle
    }
    
    public static func thumbTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .thumbTintColor, sideEffect: { $0.thumbTintColor = $1 }).toAnyStyle
    }
    
    public static func onImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .onImage, sideEffect: { $0.onImage = $1 }).toAnyStyle
    }
    
    public static func offImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .offImage, sideEffect: { $0.offImage = $1 }).toAnyStyle
    }
}
