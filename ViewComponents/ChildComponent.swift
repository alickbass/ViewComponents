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
    
    func configure(view: UIView)
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

struct ChildComponent: ConcreteComponentType {
    let component: ComponentType
    let access: (UIView) -> UIView
    
    init<V: UIView, T: UIView>(component: Component<V>, _ access: @escaping (T) -> V) {
        self.init(component, { view in access(view as! T) })
    }
    
    init(_ component: ComponentType, _ access: @escaping (UIView) -> UIView) {
        self.component = component
        self.access = access
    }
    
    var styles: Set<AnyStyle> {
        return component.styles
    }
    
    var children: [ChildComponent] {
        return component.children
    }
    
    func configure(view: UIView) {
        component.configure(view: access(view))
    }
    
    func isEqual(to other: ComponentType) -> Bool {
        guard let other = other as? ChildComponent else { return false }
        return component.isEqual(to: other.component)
    }
    
    static func == (lhs: ChildComponent, rhs: ChildComponent) -> Bool {
        return lhs.component.isEqual(to: rhs.component)
    }
    
    func diffChanges(from other: ChildComponent) -> ChildComponent {
        return ChildComponent(component.diffChanges(from: other.component), other.access)
    }
}
