//
//  ChildComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

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
    
    public var isEmpty: Bool {
        return component.isEmpty
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
