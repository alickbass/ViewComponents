//
//  ProgressViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum ProgressViewStyleKey: Int, StyleKey {
    case progress = 600, progressViewStyle, progressTintColor
    case progressImage, trackTintColor, trackImage
}

public extension AnyStyle where T: UIProgressView {
    private typealias ViewStyle<Item> = Style<T, Item, ProgressViewStyleKey>
    
    public static func progress(_ value: Float, animated: Bool) -> AnyStyle<T> {
        return ViewStyle<(Float, Bool)>((value, animated), key: .progress,
            sideEffect: { $0.setProgress($1.0, animated: $1.1) },
            equality: { $0.0 == $1.0 && $0.1 == $1.1 },
            hash: { value -> Int in
                var hash = 5381
                hash = ((hash << 5) &+ hash) &+ value.0.hashValue
                hash = ((hash << 5) &+ hash) &+ value.1.hashValue
                return hash
            }
        ).toAnyStyle
    }
    
    public static func progressViewStyle(_ value: UIProgressViewStyle) -> AnyStyle<T> {
        return ViewStyle(value, key: .progressViewStyle, sideEffect: { $0.progressViewStyle = $1 }).toAnyStyle
    }
    
    public static func progressTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .progressTintColor, sideEffect: { $0.progressTintColor = $1 }).toAnyStyle
    }
    
    public static func progressImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .progressImage, sideEffect: { $0.progressImage = $1 }).toAnyStyle
    }
    
    public static func trackTintColor(_ value: UIColor?) -> AnyStyle<T> {
        return ViewStyle(value, key: .trackTintColor, sideEffect: { $0.trackTintColor = $1 }).toAnyStyle
    }
    
    public static func trackImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .trackImage, sideEffect: { $0.trackImage = $1 }).toAnyStyle
    }
}
