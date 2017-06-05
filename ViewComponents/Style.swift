//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

protocol _AnyStyleBox {
    func sideEffect(on item: Any)
    func isEqual(to other: _AnyStyleBox) -> Bool
    var hashValue: Int { get }
}

struct _ConcreteStyleBox<Base: StyleType>: _AnyStyleBox {
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

public struct AnyStyle: StyleType {
    let style: _AnyStyleBox
    
    public init<T: StyleType>(_ style: T) {
        self.style = _ConcreteStyleBox(baseStyle: style)
    }
    
    public func sideEffect(on item: Any) {
        style.sideEffect(on: item)
    }
    
    public static func == (lhs: AnyStyle, rhs: AnyStyle) -> Bool {
        return lhs.style.isEqual(to: rhs.style)
    }
    
    public var hashValue: Int {
        return style.hashValue
    }
}

public protocol StyleType: Hashable {
    associatedtype View
    func sideEffect(on item: View)
}

protocol HashableConcreteStyle: StyleType {
    static func startIndex() -> Int
    static func stylesCount() -> Int
    static func lastStyleIndex() -> Int
    func value() -> (index: Int, valueHash: Int)
}

extension HashableConcreteStyle {
    public var hashValue: Int {
        let value = self.value()
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ (Self.startIndex() + value.index)
        hash = ((hash << 5) &+ hash) &+ value.valueHash
        return hash
    }
    
    @inline(__always) static func lastStyleIndex() -> Int {
        return Self.startIndex() + Self.stylesCount()
    }
}
