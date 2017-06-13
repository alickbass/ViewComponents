//
//  UIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIButtonStyleKey: Int, Hashable {
    case title = 65, attributedTitle, titleColor
    case titleShadowColor, reversesTitleShadowWhenHighlighted, adjustsImageWhenHighlighted
    case adjustsImageWhenDisabled, showsTouchWhenHighlighted, backgroundImage
    case image, contentEdgeInsets, titleEdgeInsets
    case imageEdgeInsets
}

public enum UIButtonStyle<T: UIButton>: KeyedStyle {
    public typealias Key = UIButtonStyleKey
    
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
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .title(title, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (title?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.title, hash)
        case let .attributedTitle(title, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (title?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.attributedTitle, hash)
        case let .titleColor(color, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.titleColor, hash)
        case let .titleShadowColor(color, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.titleShadowColor, hash)
        case let .reversesTitleShadowWhenHighlighted(reverses):
            return (.reversesTitleShadowWhenHighlighted, reverses.hashValue)
        case let .adjustsImageWhenHighlighted(adjusts):
            return (.adjustsImageWhenHighlighted, adjusts.hashValue)
        case let .adjustsImageWhenDisabled(adjusts):
            return (.adjustsImageWhenDisabled, adjusts.hashValue)
        case let .showsTouchWhenHighlighted(shows):
            return (.showsTouchWhenHighlighted, shows.hashValue)
        case let .backgroundImage(image, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (image?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.backgroundImage, hash)
        case let .image(image, for: state):
            var hash = 5381
            hash = ((hash << 5) &+ hash) &+ (image?.hashValue ?? 0)
            hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
            return (.image, hash)
        case let .contentEdgeInsets(insets):
            return (.contentEdgeInsets, insets.hashValue)
        case let .titleEdgeInsets(insets):
            return (.titleEdgeInsets, insets.hashValue)
        case let .imageEdgeInsets(insets):
            return (.imageEdgeInsets, insets.hashValue)
        }
    }
}

public extension Component where T: UIButton {
    public func button(_ styles: UIButtonStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}

struct StateInput<Input: Hashable>: Hashable {
    let value: Input?
    let state: UIControlState
    
    static func == (lhs: StateInput<Input>, rhs: StateInput<Input>) -> Bool {
        return lhs.value == rhs.value && lhs.state == rhs.state
    }
    
    var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ (value?.hashValue ?? 0)
        hash = ((hash << 5) &+ hash) &+ state.rawValue.hashValue
        return hash
    }
}

public extension AnyStyle where T: UIButton {
    private typealias ViewStyle<Item> = Style<T, Item, UIButtonStyleKey>
    
    public static func title(_ value: String?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .title, sideEffect: { $0.setTitle($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func attributedTitle(_ value: NSAttributedString?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .attributedTitle, sideEffect: { $0.setAttributedTitle($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func titleColor(_ value: UIColor?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .titleColor, sideEffect: { $0.setTitleColor($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func titleShadowColor(_ value: UIColor?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .titleShadowColor, sideEffect: { $0.setTitleShadowColor($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func reversesTitleShadowWhenHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .reversesTitleShadowWhenHighlighted, sideEffect: { $0.reversesTitleShadowWhenHighlighted = $1 }).toAnyStyle
    }
    
    public static func adjustsImageWhenHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .adjustsImageWhenHighlighted, sideEffect: { $0.adjustsImageWhenHighlighted = $1 }).toAnyStyle
    }
    
    public static func adjustsImageWhenDisabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .adjustsImageWhenDisabled, sideEffect: { $0.adjustsImageWhenDisabled = $1 }).toAnyStyle
    }
    
    public static func showsTouchWhenHighlighted(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .showsTouchWhenHighlighted, sideEffect: { $0.showsTouchWhenHighlighted = $1 }).toAnyStyle
    }
    
    public static func backgroundImage(_ value: UIImage?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .backgroundImage, sideEffect: { $0.setBackgroundImage($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func image(_ value: UIImage?, for state: UIControlState = .normal) -> AnyStyle<T> {
        let input = StateInput(value: value, state: state)
        return ViewStyle(input, key: .image, sideEffect: { $0.setImage($1.value, for: $1.state) }).toAnyStyle
    }
    
    public static func contentEdgeInsets(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentEdgeInsets, sideEffect: { $0.contentEdgeInsets = $1 }).toAnyStyle
    }
    
    public static func titleEdgeInsets(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .titleEdgeInsets, sideEffect: { $0.titleEdgeInsets = $1 }).toAnyStyle
    }
    
    public static func imageEdgeInsets(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .imageEdgeInsets, sideEffect: { $0.imageEdgeInsets = $1 }).toAnyStyle
    }
}
