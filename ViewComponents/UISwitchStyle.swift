//
//  UISwitchStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UISwitchStyleKey: Int, StyleKey {
    case isOn = 750, onTintColor, thumbTintColor, onImage, offImage
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
