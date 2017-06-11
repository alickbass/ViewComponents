//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private protocol _AnyStyleBox {
    func sideEffect(on item: Any)
    func isEqual(to other: _AnyStyleBox) -> Bool
    var hashValue: Int { get }
}

private struct _ConcreteStyleBox<Base: StyleType>: _AnyStyleBox {
    let baseStyle: Base
    
    func sideEffect(on item: Any) {
        baseStyle.sideEffect(on: item as! Base.View)
    }
    
    func isEqual(to other: _AnyStyleBox) -> Bool {
        guard let other = other as? _ConcreteStyleBox<Base> else { return false }
        return baseStyle == other.baseStyle
    }
    
    var hashValue: Int {
        return baseStyle.hashValue
    }
}

public struct AnyViewStyle: StyleType {
    private let style: _AnyStyleBox
    
    public init<T: StyleType>(_ style: T) {
        self.style = _ConcreteStyleBox(baseStyle: style)
    }
    
    public func sideEffect(on item: Any) {
        style.sideEffect(on: item)
    }
    
    public static func == (lhs: AnyViewStyle, rhs: AnyViewStyle) -> Bool {
        return lhs.style.isEqual(to: rhs.style)
    }
    
    public var hashValue: Int {
        return style.hashValue
    }
}
