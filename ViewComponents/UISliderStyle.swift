//
//  UISliderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UISliderStyle: HashableConcreteStyle {
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
    
    public func sideEffect(on view: UISlider) {
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
    
    public static func == (lhs: UISliderStyle, rhs: UISliderStyle) -> Bool {
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
    
    @inline(__always) static func startIndex() -> Int {
        return ProgressViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 12
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .currentValue(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (1, hash)
        case let .minimumValue(value):
            return (2, value.hashValue)
        case let .maximumValue(value):
            return (3, value.hashValue)
        case let .isContinuous(value):
            return (4, value.hashValue)
        case let .minimumValueImage(value):
            return (5, value?.hashValue ?? 0)
        case let .maximumValueImage(value):
            return (6, value?.hashValue ?? 0)
        case let .minimumTrackTintColor(value):
            return (7, value?.hashValue ?? 0)
        case let .minimumTrackImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (8, hash)
        case let .maximumTrackTintColor(value):
            return (9, value?.hashValue ?? 0)
        case let .maximumTrackImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (10, hash)
        case let .thumbTintColor(value):
            return (11, value?.hashValue ?? 0)
        case let .thumbImage(value, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (12, hash)
        }
    }
}

public extension Component where T: UISlider {
    public func sliderStyles(_ styles: UISliderStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
