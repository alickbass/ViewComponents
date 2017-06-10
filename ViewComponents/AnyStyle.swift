//
//  AnyStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 10/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private class _AnyStyleBoxBase: StyleType {
    func sideEffect(on item: Any) {
        fatalError()
    }
    
    func isEqual(to other: _AnyStyleBoxBase) -> Bool {
        fatalError()
    }
    
    static func == (lhs: _AnyStyleBoxBase, rhs: _AnyStyleBoxBase) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    var hashValue: Int {
        fatalError()
    }
}

private final class _AnyStyleConcreteBox<T: StyleType>: _AnyStyleBoxBase {
    let base: T
    
    init(_ base: T) {
        self.base = base
    }
    
    override func sideEffect(on item: Any) {
        base.sideEffect(on: item as! T.View)
    }
    
    override func isEqual(to other: _AnyStyleBoxBase) -> Bool {
        guard let other = other as? _AnyStyleConcreteBox<T> else { return false }
        return self.base == other.base
    }
    
    override var hashValue: Int {
        return base.hashValue
    }
}

public final class AnyStyle<T>: StyleType {
    private let box: _AnyStyleBoxBase
    
    private init(_ box: _AnyStyleBoxBase) {
        self.box = box
    }
    
    public init<V: StyleType>(_ style: V) where V.View == T {
        self.box = _AnyStyleConcreteBox(style)
    }
    
    func unsafeCast<V>(to type: V.Type) -> AnyStyle<V> {
        return AnyStyle<V>(box)
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
