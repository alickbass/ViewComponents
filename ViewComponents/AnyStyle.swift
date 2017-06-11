//
//  AnyStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 10/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

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

public struct AnyStyle<T>: StyleType {
    private let box: _AnyStyleBoxBase<T>
    
    public init<V: StyleType>(_ style: V) where V.View == T {
        box = _AnyStyleConcreteBox(style)
    }
    
    public func sideEffect(on item: T) {
        box.sideEffect(on: item)
    }
    
    public static func == (lhs: AnyStyle<T>, rhs: AnyStyle<T>) -> Bool {
        return lhs.box == rhs.box
    }
    
    public var hashValue: Int {
        return box.hashValue
    }
}

private class _AnyStyleBoxBase<V>: StyleType {
    func sideEffect(on item: V) {
        fatalError()
    }
    
    func isEqual(to other: _AnyStyleBoxBase<V>) -> Bool {
        fatalError()
    }
    
    static func == (lhs: _AnyStyleBoxBase<V>, rhs: _AnyStyleBoxBase<V>) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    var hashValue: Int {
        fatalError()
    }
}

private final class _AnyStyleConcreteBox<T: StyleType>: _AnyStyleBoxBase<T.View> {
    let base: T
    
    init(_ base: T) {
        self.base = base
    }
    
    override func sideEffect(on item: T.View) {
        base.sideEffect(on: item)
    }
    
    override func isEqual(to other: _AnyStyleBoxBase<T.View>) -> Bool {
        guard let other = other as? _AnyStyleConcreteBox<T> else { return false }
        return self.base == other.base
    }
    
    override var hashValue: Int {
        return base.hashValue
    }
}
