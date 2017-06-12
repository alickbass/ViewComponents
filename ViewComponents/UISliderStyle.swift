//
//  UISliderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UISliderStyle<T: UISlider>: KeyedStyle {
    public enum Key: Int, Hashable {
        case currentValue = 189, minimumValue, maximumValue
        case isContinuous, minimumValueImage, maximumValueImage
        case minimumTrackTintColor, minimumTrackImage, maximumTrackTintColor
        case maximumTrackImage, thumbTintColor, thumbImage
    }
    
    case currentValue(Float, animated: Bool)
    case minimumValue(Float)
    case maximumValue(Float)
    case isContinuous(Bool)
    case minimumValueImage(UIImage?)
    case maximumValueImage(UIImage?)
    case minimumTrackTintColor(UIColor?)
    case minimumTrackImage(UIImage?, for: UIControlState)
    case maximumTrackTintColor(UIColor?)
    case maximumTrackImage(UIImage?, for: UIControlState)
    case thumbTintColor(UIColor?)
    case thumbImage(UIImage?, for: UIControlState)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .currentValue(value, animated: animated):
            view.setValue(value, animated: animated)
        case let .minimumValue(value):
            view.minimumValue = value
        case let .maximumValue(value):
            view.maximumValue = value
        case let .isContinuous(value):
            view.isContinuous = value
        case let .minimumValueImage(value):
            view.minimumValueImage = value
        case let .maximumValueImage(value):
            view.maximumValueImage = value
        case let .minimumTrackTintColor(value):
            view.minimumTrackTintColor = value
        case let .minimumTrackImage(value, for: state):
            view.setMinimumTrackImage(value, for: state)
        case let .maximumTrackTintColor(value):
            view.maximumTrackTintColor = value
        case let .maximumTrackImage(value, for: state):
            view.setMaximumTrackImage(value, for: state)
        case let .thumbTintColor(value):
            view.thumbTintColor = value
        case let .thumbImage(value, for: state):
            view.setThumbImage(value, for: state)
        }
    }
    
    public static func == (lhs: UISliderStyle<T>, rhs: UISliderStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.currentValue(left, animated: leftAnimated), .currentValue(right, animated: rightAnimated)):
            return left == right && leftAnimated == rightAnimated
        case let (.minimumValue(left), .minimumValue(right)),
             let (.maximumValue(left), .maximumValue(right)):
            return left == right
        case let (.isContinuous(left), .isContinuous(right)):
            return left == right
        case let (.minimumValueImage(left), .minimumValueImage(right)),
             let (.maximumValueImage(left), .maximumValueImage(right)):
            return left == right
        case let (.minimumTrackTintColor(left), .minimumTrackTintColor(right)),
             let (.maximumTrackTintColor(left), .maximumTrackTintColor(right)),
             let (.thumbTintColor(left), .thumbTintColor(right)):
            return left == right
        case let (.minimumTrackImage(left, for: leftState), .minimumTrackImage(right, for: rightState)),
             let (.maximumTrackImage(left, for: leftState), .maximumTrackImage(right, for: rightState)),
             let (.thumbImage(left, for: leftState), .thumbImage(right, for: rightState)):
            return left == right && leftState == rightState
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .currentValue(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (.currentValue, hash)
        case let .minimumValue(value):
            return (.minimumValue, value.hashValue)
        case let .maximumValue(value):
            return (.maximumValue, value.hashValue)
        case let .isContinuous(value):
            return (.isContinuous, value.hashValue)
        case let .minimumValueImage(value):
            return (.minimumValueImage, value?.hashValue ?? 0)
        case let .maximumValueImage(value):
            return (.maximumValueImage, value?.hashValue ?? 0)
        case let .minimumTrackTintColor(value):
            return (.minimumTrackTintColor, value?.hashValue ?? 0)
        case let .minimumTrackImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.minimumTrackImage, hash)
        case let .maximumTrackTintColor(value):
            return (.maximumTrackTintColor, value?.hashValue ?? 0)
        case let .maximumTrackImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.maximumTrackImage, hash)
        case let .thumbTintColor(value):
            return (.thumbTintColor, value?.hashValue ?? 0)
        case let .thumbImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.thumbImage, hash)
        }
    }
}

public extension Component where T: UISlider {
    public func slider(_ styles: UISliderStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
