//
//  ChildComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private protocol _ChildComponent {}

private protocol _AnyComponentBox {
    var children: [_ChildComponent] { get }
    var isEmpty: Bool { get }
    
    func configure(item: Any)
    func isEqual(to other: _AnyComponentBox) -> Bool
    func diffChanges(from other: _AnyComponentBox) -> _AnyComponentBox
}

private struct _ConcreteComponentBox<Base: ComponentType>: _AnyComponentBox {
    let base: Base
    
    var children: [_ChildComponent] {
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

public struct ChildComponent<View>: ComponentType, _ChildComponent {
    private let box: _AnyComponentBox
    let access: (View) -> Any
    
    public init<V: ComponentType>(component: V, _ access: @escaping (View) -> V.View) {
        self.init(_ConcreteComponentBox(base: component), access)
    }
    
    private init(_ box: _AnyComponentBox, _ access: @escaping (View) -> Any) {
        self.box = box
        self.access = access
    }
    
    public static func child<V, E: ComponentConvertible>(_ access: @escaping (View) -> V, _ item: E) -> ChildComponent<View> where E.ComponentViewType == V {
        return ChildComponent<View>(component: item.toComponent, access)
    }
    
    public static func child<V>(_ access: @escaping (View) -> V, styles: AnyStyle<V>...) -> ChildComponent<View> {
        return ChildComponent<View>(component: Component<V>(styles: styles, children: []), access)
    }
    
    public var isEmpty: Bool {
        return box.isEmpty
    }
    
    public var children: [ChildComponent<View>] {
        return box.children as! [ChildComponent<View>]
    }
    
    public func configure(item: View) {
        box.configure(item: access(item))
    }
    
    public static func == (lhs: ChildComponent, rhs: ChildComponent) -> Bool {
        return lhs.box.isEqual(to: rhs.box)
    }
    
    public func diffChanges(from other: ChildComponent<View>) -> ChildComponent<View> {
        return ChildComponent(box.diffChanges(from: other.box), other.access)
    }
}
