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
    func diffChanges<T: ComponentConvertible>(from other: T) -> Component<ViewType> where T.ViewType == ViewType
}

public extension ComponentConvertible {
    public func configure(item: ViewType) {
        toComponent.configure(item: item)
    }
    
    public func diffChanges<T: ComponentConvertible>(from other: T) -> Component<ViewType> where T.ViewType == ViewType {
        return toComponent.diffChanges(from: other.toComponent)
    }
}

// MARK: - Component Protocol
public protocol ComponentType: Equatable {
    associatedtype View
    
    var children: [ChildComponent] { get }
    var isEmpty: Bool { get }
    
    func configure(item: View)
    func diffChanges(from other: Self) -> Self
}

// MARK: - Component View Protocol
public protocol ComponentContainingView: class {
    associatedtype ViewModel: ComponentConvertible
    var item: ViewModel? { get set }
    func configure(with newItem: ViewModel)
}

public extension ComponentContainingView where ViewModel.ViewType == Self {
    public func configure(with newItem: ViewModel) {
        (item?.diffChanges(from: newItem) ?? newItem.toComponent).configure(item: self)
        item = newItem
    }
}
