//
//  UISliderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UISliderStyleKey: Int, StyleKey {
    case currentValue = 650, minimumValue, maximumValue
    case isContinuous, minimumValueImage, maximumValueImage
    case minimumTrackTintColor, minimumTrackImage, maximumTrackTintColor
    case maximumTrackImage, thumbTintColor, thumbImage
}

public extension AnyStyle where T: UISlider {
    private typealias ViewStyle<Item> = Style<T, Item, UISliderStyleKey>
    
    public static func currentValue(_ value: Float, animated: Bool) -> AnyStyle<T> {
        return ViewStyle<(Float, Bool)>((value, animated), key: .currentValue,
            sideEffect: { $0.setValue($1.0, animated: $1.1) },
            equality: { $0.0 == $1.0 && $0.1 == $1.1 },
            hash: { value -> Int in
                var hash = 5381
                hash = ((hash << 5) &+ hash) &+ value.0.hashValue
                hash = ((hash << 5) &+ hash) &+ value.1.hashValue
                return hash
            }
        ).toAnyStyle
    }
    
    public static func minimumValue(_ value: Float) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumValue, sideEffect: { $0.minimumValue = $1 }).toAnyStyle
    }
    
    public static func maximumValue(_ value: Float) -> AnyStyle<T> {
        return ViewStyle(value, key: .maximumValue, sideEffect: { $0.maximumValue = $1 }).toAnyStyle
    }
    
    public static func isContinuous(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isContinuous, sideEffect: { $0.isContinuous = $1 }).toAnyStyle
    }
    
    public static func minimumValueImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumValueImage, sideEffect: { $0.minimumValueImage = $1 }).toAnyStyle
    }
    
    public static func maximumValueImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .maximumValueImage, sideEffect: { $0.maximumValueImage = $1 }).toAnyStyle
    }
    
    public static func minimumTrackTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .minimumTrackTintColor, sideEffect: { $0.minimumTrackTintColor = $1 }).toAnyStyle
    }
    
    public static func minimumTrackImage(_ value: UIImage?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .minimumTrackImage, sideEffect: { $0.setMinimumTrackImage($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func maximumTrackTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .maximumTrackTintColor, sideEffect: { $0.maximumTrackTintColor = $1 }).toAnyStyle
    }
    
    public static func maximumTrackImage(_ value: UIImage?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .maximumTrackImage, sideEffect: { $0.setMaximumTrackImage($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func thumbTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .thumbTintColor, sideEffect: { $0.thumbTintColor = $1 }).toAnyStyle
    }
    
    public static func thumbImage(_ value: UIImage?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .thumbImage, sideEffect: { $0.setThumbImage($1.value, for: $1.state) }).toAnyStyle
    }
}
