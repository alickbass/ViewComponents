//
//  Component.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public struct Component<T>: ConcreteComponentType {
    public let styles: Set<AnyStyle>
    public let children: [ChildComponent]
    
    public init() {
        self.init(styles: [], children: [])
    }
    
    init(styles: Set<AnyStyle>, children: [ChildComponent]) {
        self.styles = styles
        self.children = children
    }
    
    public var isEmpty: Bool {
        return styles.isEmpty && children.isEmpty
    }
    
    func adding<S: StyleType>(styles: [S]) -> Component<T> {
        return Component<T>(styles: self.styles.union(styles.lazy.map(AnyStyle.init)), children: children)
    }
    
    public func configure(item: T) {
        styles.forEach { $0.sideEffect(on: item) }
        children.forEach { $0.configure(item: item) }
    }
    
    public func child<V, E: ComponentConvertible>(_ access: @escaping (T) -> V, _ item: E) -> Component<T> where E.ViewType == V {
        return Component<T>(styles: styles, children: children + [ChildComponent(component: item.toComponent, access)])
    }
}

extension Component {
    public func diffChanges(from other: Component<T>) -> Component<T> {
        let newStyles = other.styles.subtracting(styles)
        let newChildren = other.children.lazy.enumerated().flatMap({ current -> ChildComponent? in
            if current.offset < children.count {
                let diff = children[current.offset].diffChanges(from: current.element)
                return diff.isEmpty ? nil : diff
            } else {
                return current.element
            }
        })
        return Component<T>(styles: newStyles, children: newChildren)
    }
}

extension Component: ComponentConvertible {
    public var toComponent: Component<T> {
        return self
    }
}

extension Component {
    public static func == (lhs: Component<T>, rhs: Component<T>) -> Bool {
        return lhs.styles == rhs.styles && lhs.children == rhs.children
    }
}
