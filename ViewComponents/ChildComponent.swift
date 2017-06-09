//
//  ChildComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private protocol _AnyComponentBox {
    var children: [ChildComponent] { get }
    var isEmpty: Bool { get }
    
    func configure(item: Any)
    func isEqual(to other: _AnyComponentBox) -> Bool
    func diffChanges(from other: _AnyComponentBox) -> _AnyComponentBox
}

private struct _ConcreteComponentBox<Base: ConcreteComponentType>: _AnyComponentBox {
    let base: Base
    
    var children: [ChildComponent] {
        return base.children
    }
    
    var isEmpty: Bool {
        return base.isEmpty
    }
    
    func configure(item: Any) {
        base.configure(item: item as! Base.View)
    }
    
    func isEqual(to other: _AnyComponentBox) -> Bool {
        guard let other = other as? _ConcreteComponentBox<Base> else { return false }
        return base == other.base
    }
    
    func diffChanges(from other: _AnyComponentBox) -> _AnyComponentBox {
        guard let otherComp = other as? _ConcreteComponentBox<Base> else { return other }
        return _ConcreteComponentBox<Base>(base: base.diffChanges(from: otherComp.base))
    }
}

public struct ChildComponent: ConcreteComponentType {
    private let box: _AnyComponentBox
    let access: (Any) -> Any
    
    public init<V, T>(component: Component<V>, _ access: @escaping (T) -> V) {
        self.init(_ConcreteComponentBox(base: component), { view in access(view as! T) })
    }
    
    private init(_ box: _AnyComponentBox, _ access: @escaping (Any) -> Any) {
        self.box = box
        self.access = access
    }
    
    public var isEmpty: Bool {
        return box.isEmpty
    }
    
    public var children: [ChildComponent] {
        return box.children
    }
    
    public func configure(item: Any) {
        box.configure(item: access(item))
    }
    
    public static func == (lhs: ChildComponent, rhs: ChildComponent) -> Bool {
        return lhs.box.isEqual(to: rhs.box)
    }
    
    public func diffChanges(from other: ChildComponent) -> ChildComponent {
        return ChildComponent(box.diffChanges(from: other.box), other.access)
    }
}
