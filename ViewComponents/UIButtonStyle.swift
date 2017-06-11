//
//  UIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIButtonStyle<T: UIButton>: HashableConcreteStyle {
    case title(String?, for: UIControlState)
    case attributedTitle(NSAttributedString?, for: UIControlState)
    case titleColor(UIColor?, for: UIControlState)
    case titleShadowColor(UIColor?, for: UIControlState)
    case reversesTitleShadowWhenHighlighted(Bool)
    case adjustsImageWhenHighlighted(Bool)
    case adjustsImageWhenDisabled(Bool)
    case showsTouchWhenHighlighted(Bool)
    case backgroundImage(UIImage?, for: UIControlState)
    case image(UIImage?, for: UIControlState)
    case contentEdgeInsets(UIEdgeInsets)
    case titleEdgeInsets(UIEdgeInsets)
    case imageEdgeInsets(UIEdgeInsets)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .title(title, for: state):
            view.setTitle(title, for: state)
        case let .attributedTitle(title, for: state):
            view.setAttributedTitle(title, for: state)
        case let .titleColor(color, for: state):
            view.setTitleColor(color, for: state)
        case let .titleShadowColor(color, for: state):
            view.setTitleShadowColor(color, for: state)
        case let .reversesTitleShadowWhenHighlighted(reverses):
            view.reversesTitleShadowWhenHighlighted = reverses
        case let .adjustsImageWhenHighlighted(adjusts):
            view.adjustsImageWhenHighlighted = adjusts
        case let .adjustsImageWhenDisabled(adjusts):
            view.adjustsImageWhenDisabled = adjusts
        case let .showsTouchWhenHighlighted(shows):
            view.showsTouchWhenHighlighted = shows
        case let .backgroundImage(image, for: state):
            view.setBackgroundImage(image, for: state)
        case let .image(image, for: state):
            view.setImage(image, for: state)
        case let .contentEdgeInsets(insets):
            view.contentEdgeInsets = insets
        case let .titleEdgeInsets(insets):
            view.titleEdgeInsets = insets
        case let .imageEdgeInsets(insets):
            view.imageEdgeInsets = insets
        }
    }
    
    public static func == (lhs: UIButtonStyle<T>, rhs: UIButtonStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.title(leftTitle, for: leftState), .title(rightTitle, for: rightState)):
            return leftTitle == rightTitle && leftState == rightState
        case let (.attributedTitle(leftTitle, for: leftState), .attributedTitle(rightTitle, for: rightState)):
            return leftTitle == rightTitle && leftState == rightState
        case let (.titleColor(leftColor, for: leftState), .titleColor(rightColor, for: rightState)),
             let (.titleShadowColor(leftColor, for: leftState), .titleShadowColor(rightColor, for: rightState)):
            return leftColor == rightColor && leftState == rightState
        case let (.reversesTitleShadowWhenHighlighted(leftBool), .reversesTitleShadowWhenHighlighted(rightBool)),
             let (.adjustsImageWhenHighlighted(leftBool), .adjustsImageWhenHighlighted(rightBool)),
             let (.adjustsImageWhenDisabled(leftBool), .adjustsImageWhenDisabled(rightBool)),
             let (.showsTouchWhenHighlighted(leftBool), .showsTouchWhenHighlighted(rightBool)):
            return leftBool == rightBool
        case let (.backgroundImage(leftImage, for: leftState), .backgroundImage(rightImage, for: rightState)),
             let (.image(leftImage, for: leftState), .image(rightImage, for: rightState)):
            return leftImage == rightImage && leftState == rightState
        case let (.contentEdgeInsets(leftInsets), .contentEdgeInsets(rightInsets)),
             let (.titleEdgeInsets(leftInsets), .titleEdgeInsets(rightInsets)),
             let (.imageEdgeInsets(leftInsets), .imageEdgeInsets(rightInsets)):
            return leftInsets == rightInsets
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return UIControlStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 13
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .title(title, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (title?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (1, hash)
        case let .attributedTitle(title, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (title?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (2, hash)
        case let .titleColor(color, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (3, hash)
        case let .titleShadowColor(color, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (4, hash)
        case let .reversesTitleShadowWhenHighlighted(reverses):
            return (5, reverses.hashValue)
        case let .adjustsImageWhenHighlighted(adjusts):
            return (6, adjusts.hashValue)
        case let .adjustsImageWhenDisabled(adjusts):
            return (7, adjusts.hashValue)
        case let .showsTouchWhenHighlighted(shows):
            return (8, shows.hashValue)
        case let .backgroundImage(image, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (image?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (9, hash)
        case let .image(image, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (image?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (10, hash)
        case let .contentEdgeInsets(insets):
            return (11, insets.hashValue)
        case let .titleEdgeInsets(insets):
            return (12, insets.hashValue)
        case let .imageEdgeInsets(insets):
            return (13, insets.hashValue)
        }
    }
}

public extension Component where T: UIButton {
    public func button(_ styles: UIButtonStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
