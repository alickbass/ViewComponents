//
//  Component.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

protocol ComponentType {
    var styles: [AnyStyle] { get }
    func configure(view: UIView)
    func isEqual(to other: ComponentType) -> Bool
}

struct ChildComponent: Equatable {
    let component: ComponentType
    let access: (UIView) -> UIView
    
    init<V: UIView, T: UIView>(component: Component<V>, _ access: @escaping (T) -> V) {
        self.component = component
        self.access = { view in access(view as! T) }
    }
    
    func configure(view: UIView) {
        component.configure(view: access(view))
    }
    
    static func == (lhs: ChildComponent, rhs: ChildComponent) -> Bool {
        return lhs.component.isEqual(to: rhs.component)
    }
}

public struct Component<T: UIView>: ComponentType {
    public let styles: [AnyStyle]
    let children: [ChildComponent]
    
    public init() {
        self.init(styles: [], children: [])
    }
    
    init(styles: [AnyStyle], children: [ChildComponent]) {
        self.styles = styles
        self.children = children
    }
    
    func configure(view: UIView) {
        configure(view: view as! T)
    }
    
    public func add<S: StyleType>(styles: [S]) -> Component<T> {
        return Component<T>(styles: self.styles + styles.map(AnyStyle.init), children: children)
    }
    
    public func configure(view: T) {
        styles.forEach { $0.sideEffect(view: view) }
        children.forEach({ $0.configure(view: view) })
    }
    
    public func child<V: UIView>(_ component: Component<V>, _ access: @escaping (T) -> V) -> Component<T> {
        return Component<T>(styles: styles, children: children + [ChildComponent(component: component, access)])
    }
}

extension Component: ComponentConvertible {
    public var toComponent: Component<T> {
        return self
    }
}

extension Component: Equatable {
    func isEqual(to other: ComponentType) -> Bool {
        guard let other = other as? Component<T> else { return false }
        return self == other
    }
    
    public static func == (lhs: Component<T>, rhs: Component<T>) -> Bool {
        return lhs.styles == rhs.styles && lhs.children == rhs.children
    }
}

public protocol ComponentConvertible {
    associatedtype ViewType: UIView
    
    var toComponent: Component<ViewType> { get }
    func configure(view: ViewType)
}

public extension ComponentConvertible {
    public func configure(view: ViewType) {
        toComponent.configure(view: view)
    }
}
