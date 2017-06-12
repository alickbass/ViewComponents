//
//  UIImageViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 03/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIImageViewStyle<T: UIImageView>: KeyedStyle {
    public enum Key: Int, Hashable {
        case image = 78, highlightedImage, animationImages
        case highlightedAnimationImages, animationDuration, animationRepeatCount
        case isHighlighted
    }
    
    case image(UIImage?)
    case highlightedImage(UIImage?)
    case animationImages([UIImage]?)
    case highlightedAnimationImages([UIImage]?)
    case animationDuration(TimeInterval)
    case animationRepeatCount(Int)
    case isHighlighted(Bool)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .image(image):
            view.image = image
        case let .highlightedImage(image):
            view.highlightedImage = image
        case let .animationImages(images):
            view.animationImages = images
        case let .highlightedAnimationImages(images):
            view.highlightedAnimationImages = images
        case let .animationDuration(duration):
            view.animationDuration = duration
        case let .animationRepeatCount(animationRepeatCount):
            view.animationRepeatCount = animationRepeatCount
        case let .isHighlighted(isHighlighted):
            view.isHighlighted = isHighlighted
        }
    }
    
    public static func == (lhs: UIImageViewStyle<T>, rhs: UIImageViewStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.image(leftImage), .image(rightImage)),
             let (.highlightedImage(leftImage), .highlightedImage(rightImage)):
            return leftImage == rightImage
        case let (.animationImages(leftImages), .animationImages(rightImages)),
             let (.highlightedAnimationImages(leftImages), .highlightedAnimationImages(rightImages)):
            switch (leftImages, rightImages) {
            case (nil, nil):
                return true
            case let (left?, right?):
                return left == right
            default:
                return false
            }
        case let (.animationDuration(leftDuration), .animationDuration(rightDuration)):
            return leftDuration == rightDuration
        case let (.animationRepeatCount(leftCount), .animationRepeatCount(rightCount)):
            return leftCount == rightCount
        case let (.isHighlighted(leftBool), .isHighlighted(rightBool)):
            return leftBool == rightBool
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .image(image):
            return (.image, image?.hashValue ?? 0)
        case let .highlightedImage(image):
            return (.highlightedImage, image?.hashValue ?? 0)
        case let .animationImages(images):
            let hash = images.map({ $0.reduce(5381, { (($0.0 << 5) &+ $0.0) &+ $0.1.hashValue }) })
            return (.animationImages, hash ?? 0)
        case let .highlightedAnimationImages(images):
            let hash = images.map({ $0.reduce(5381, { (($0.0 << 5) &+ $0.0) &+ $0.1.hashValue }) })
            return (.highlightedAnimationImages, hash ?? 0)
        case let .animationDuration(duration):
            return (.animationDuration, duration.hashValue)
        case let .animationRepeatCount(animationRepeatCount):
            return (.animationRepeatCount, animationRepeatCount.hashValue)
        case let .isHighlighted(isHighlighted):
            return (.isHighlighted, isHighlighted.hashValue)
        }
    }
}

public extension Component where T: UIImageView {
    public func imageView(_ styles: UIImageViewStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
