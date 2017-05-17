//
//  ComponentProtocols.swift
//  ViewComponents
//
//  Created by Oleksii on 17/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

// MARK: - Component Convertible

public protocol ComponentConvertible {
    associatedtype ViewType
    
    var toComponent: Component<ViewType> { get }
    func configure(item: ViewType)
}

public extension ComponentConvertible {
    public func configure(item: ViewType) {
        toComponent.configure(item: item)
    }
}

// MARK: - Component Protocol

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
