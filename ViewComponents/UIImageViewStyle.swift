//
//  UIImageViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 03/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIImageViewStyleKey: Int, Hashable {
    case image = 250, highlightedImage, animationImages
    case highlightedAnimationImages, animationDuration, animationRepeatCount
    case isHighlighted
}

public extension AnyStyle where T: UIImageView {
    private typealias ViewStyle<Item> = Style<T, Item, UIImageViewStyleKey>
    
    public static func image(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .image, sideEffect: { $0.image = $1 }).toAnyStyle
    }
    
    public static func highlightedImage(_ value: UIImage?) -> AnyStyle<T> {
        return ViewStyle(value, key: .highlightedImage, sideEffect: { $0.highlightedImage = $1 }).toAnyStyle
    }
    
    public static func animationImages(_ value: [UIImage]?) -> AnyStyle<T> {
        return ViewStyle(value, key: .animationImages,
            sideEffect: { $0.animationImages = $1 },
            equality: { $0 == $1 },
            hash: { $0.hashValue }
        ).toAnyStyle
    }
    
    public static func highlightedAnimationImages(_ value: [UIImage]?) -> AnyStyle<T> {
        return ViewStyle(value, key: .highlightedAnimationImages,
            sideEffect: { $0.highlightedAnimationImages = $1 },
            equality: { $0 == $1 },
            hash: { $0.hashValue }
        ).toAnyStyle
    }
    
    public static func animationDuration(_ value: TimeInterval) -> AnyStyle<T> {
        return ViewStyle(value, key: .animationDuration, sideEffect: { $0.animationDuration = $1 }).toAnyStyle
    }
    
    public static func animationRepeatCount(_ value: Int) -> AnyStyle<T> {
        return ViewStyle(value, key: .animationRepeatCount, sideEffect: { $0.animationRepeatCount = $1 }).toAnyStyle
    }
    
    public static func isHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHighlighted, sideEffect: { $0.isHighlighted = $1 }).toAnyStyle
    }
}

private extension Optional where Wrapped == [UIImage]  {
    static func == (lhs: [UIImage]?, rhs: [UIImage]?) -> Bool {
        switch (lhs, rhs) {
        case (nil, nil):
            return true
        case let (left?, right?):
            return left == right
        default:
            return false
        }
    }
    
    var hashValue: Int {
        return map({ $0.reduce(5381, { (($0.0 << 5) &+ $0.0) &+ $0.1.hashValue }) }) ?? 0
    }
}
