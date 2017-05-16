//
//  ProgressViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum ProgressViewStyle: HashableConcreteStyle {
    case progress(Float, animated: Bool)
    case progressViewStyle(UIProgressViewStyle)
    case progressTintColor(UIColor?)
    case progressImage(UIImage?)
    case trackTintColor(UIColor?)
    case trackImage(UIImage?)
    
    public func sideEffect(on view: UIProgressView) {
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
    
    public static func == (lhs: ProgressViewStyle, rhs: ProgressViewStyle) -> Bool {
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
    
    @inline(__always) static func startIndex() -> Int {
        return UITextViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 6
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .progress(value, animated: animated):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ value.hashValue
            hash = ((hash << 5) &+ hash) &+ animated.hashValue
            return (1, hash)
        case let .progressViewStyle(value):
            return (2, value.hashValue)
        case let .progressTintColor(value):
            return (3, value?.hashValue ?? 0)
        case let .progressImage(value):
            return (4, value?.hashValue ?? 0)
        case let .trackTintColor(value):
            return (5, value?.hashValue ?? 0)
        case let .trackImage(value):
            return (6, value?.hashValue ?? 0)
        }
    }
}

public extension Component where T: UIProgressView {
    public func progressView(_ styles: ProgressViewStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
