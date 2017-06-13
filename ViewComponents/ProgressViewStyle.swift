//
//  ProgressViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum ProgressViewStyleKey: Int, Hashable {
    case progress = 183, progressViewStyle, progressTintColor
    case progressImage, trackTintColor, trackImage
}

public enum ProgressViewStyle<T: UIProgressView>: KeyedStyle {
    public typealias Key = ProgressViewStyleKey
    
    case progress(Float, animated: Bool)
    case progressViewStyle(UIProgressViewStyle)
    case progressTintColor(UIColor?)
    case progressImage(UIImage?)
    case trackTintColor(UIColor?)
    case trackImage(UIImage?)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .progress(value, animated: animated):
            view.setProgress(value, animated: animated)
        case let .progressViewStyle(value):
            view.progressViewStyle = value
        case let .progressTintColor(value):
            view.progressTintColor = value
        case let .progressImage(value):
            view.progressImage = value
        case let .trackTintColor(value):
            view.trackTintColor = value
        case let .trackImage(value):
            view.trackImage = value
        }
    }
    
    public static func == (lhs: ProgressViewStyle<T>, rhs: ProgressViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.progress(left, animated: leftAnimated), .progress(right, animated: rightAnimated)):
            return left == right && leftAnimated == rightAnimated
        case let (.progressViewStyle(left), .progressViewStyle(right)):
            return left == right
        case let (.progressTintColor(left), .progressTintColor(right)),
             let (.trackTintColor(left), .trackTintColor(right)):
            return left == right
        case let (.progressImage(left), .progressImage(right)),
             let (.trackImage(left), .trackImage(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .progress(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (.progress, hash)
        case let .progressViewStyle(value):
            return (.progressViewStyle, value.hashValue)
        case let .progressTintColor(value):
            return (.progressTintColor, value?.hashValue ?? 0)
        case let .progressImage(value):
            return (.progressImage, value?.hashValue ?? 0)
        case let .trackTintColor(value):
            return (.trackTintColor, value?.hashValue ?? 0)
        case let .trackImage(value):
            return (.trackImage, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UIProgressView {
    public func progressView(_ styles: ProgressViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
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
