//
//  UIButtonStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIButtonStyleKey: Int, Hashable {
    case title = 65, attributedTitle, titleColor
    case titleShadowColor, reversesTitleShadowWhenHighlighted, adjustsImageWhenHighlighted
    case adjustsImageWhenDisabled, showsTouchWhenHighlighted, backgroundImage
    case image, contentEdgeInsets, titleEdgeInsets
    case imageEdgeInsets
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
