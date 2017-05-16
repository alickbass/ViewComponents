//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public struct AnyStyle: StyleType, Hashable {
    public let style: StyleType
    
    public init(_ style: StyleType) {
        self.style = style
    }
    
    public func sideEffect(view: Any) {
        style.sideEffect(view: view)
    }
    
    public func isEqual(to other: StyleType) -> Bool {
        guard let other = other as? AnyStyle else { return false }
        return self == other
    }
    
    public static func == (lhs: AnyStyle, rhs: AnyStyle) -> Bool {
        return lhs.style.isEqual(to: rhs.style)
    }
    
    public var hashValue: Int {
        return style.hashValue
    }
}

public protocol StyleType {
    func sideEffect(view: Any)
    func isEqual(to other: StyleType) -> Bool
    var hashValue: Int { get }
}

public protocol ConcreteStyleType: StyleType, Hashable {
    associatedtype View
    func sideEffect(on view: View)
}

public extension ConcreteStyleType {
    public func sideEffect(view: Any) {
        sideEffect(on: view as! View)
    }
    
    public func isEqual(to other: StyleType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

protocol HashableConcreteStyle: ConcreteStyleType {
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
