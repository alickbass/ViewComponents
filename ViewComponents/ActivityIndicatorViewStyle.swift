//
//  ActivityIndicatorViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 15/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum ActivityIndicatorViewStyleKey: Int, Hashable {
    case isAnimating = 700, hidesWhenStopped, activityIndicatorViewStyle, color
}

public extension AnyStyle where T: UIActivityIndicatorView {
    private typealias ViewStyle<Item> = Style<T, Item, ActivityIndicatorViewStyleKey>
    
    public static func isAnimating(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isAnimating, sideEffect: { $1 ? $0.startAnimating() : $0.stopAnimating() }).toAnyStyle
    }
    
    public static func hidesWhenStopped(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .hidesWhenStopped, sideEffect: { $0.hidesWhenStopped = $1 }).toAnyStyle
    }
    
    public static func activityIndicatorViewStyle(_ value: UIActivityIndicatorViewStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .activityIndicatorViewStyle, sideEffect: { $0.activityIndicatorViewStyle = $1 }).toAnyStyle
    }
    
    public static func color(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .color, sideEffect: { $0.color = $1 }).toAnyStyle
    }
}
