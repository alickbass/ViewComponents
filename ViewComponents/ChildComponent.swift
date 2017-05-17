//
//  ChildComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

protocol ComponentType {
    var styles: Set<AnyStyle> { get }
    var children: [ChildComponent] { get }
    var isEmpty: Bool { get }
    
    func configure(item: Any)
    func isEqual(to other: ComponentType) -> Bool
    func diffChanges(from other: ComponentType) -> ComponentType
}

protocol ConcreteComponentType: ComponentType, Equatable {
    func diffChanges(from other: Self) -> Self
}

extension ComponentType {
    var isEmpty: Bool {
        return styles.isEmpty && children.isEmpty
    }
}

extension ConcreteComponentType {
    func diffChanges(from other: ComponentType) -> ComponentType {
        guard let otherComp = other as? Self else { return other }
        return diffChanges(from: otherComp)
    }
}

public struct ChildComponent: ConcreteComponentType {
    let component: ComponentType
    public let access: (Any) -> Any
    
    init<V, T>(component: Component<V>, _ access: @escaping (T) -> V) {
        self.init(component, { view in access(view as! T) })
    }
    
    init(_ component: ComponentType, _ access: @escaping (Any) -> Any) {
        self.component = component
        self.access = access
    }
    
    public var styles: Set<AnyStyle> {
        return component.styles
    }
    
    public var children: [ChildComponent] {
        return component.children
    }
    
    func configure(item: Any) {
        component.configure(item: access(item))
    }
    
    func isEqual(to other: ComponentType) -> Bool {
        guard let other = other as? ChildComponent else { return false }
        return component.isEqual(to: other.component)
    }
    
    public static func == (lhs: ChildComponent, rhs: ChildComponent) -> Bool {
        return lhs.component.isEqual(to: rhs.component)
    }
    
    public func diffChanges(from other: ChildComponent) -> ChildComponent {
        return ChildComponent(component.diffChanges(from: other.component), other.access)
    }
}
