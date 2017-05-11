//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public struct AnyStyle: StyleType, Equatable {
    public let style: StyleType
    
    public init(_ style: StyleType) {
        self.style = style
    }
    
    public func sideEffect(view: UIView) {
        style.sideEffect(view: view)
    }
    
    public func isEqual(to other: StyleType) -> Bool {
        guard let other = other as? AnyStyle else { return false }
        return self == other
    }
    
    public static func == (lhs: AnyStyle, rhs: AnyStyle) -> Bool {
        return lhs.style.isEqual(to: rhs.style)
    }
}

public protocol StyleType {
    func sideEffect(view: UIView)
    func isEqual(to other: StyleType) -> Bool
}

public protocol ConcreteStyleType: StyleType, Hashable {
    associatedtype View: UIView
    func sideEffect(on view: View)
}

public extension ConcreteStyleType {
    public func sideEffect(view: UIView) {
        sideEffect(on: view as! View)
    }
    
    public func isEqual(to other: StyleType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

protocol HashableConcreteStyle: ConcreteStyleType {
    var startIndex: Int { get }
    var value: (index: Int, valueHash: Int) { get }
}

extension HashableConcreteStyle {
    public var hashValue: Int {
        let value = self.value
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ (startIndex + value.index)
        hash = ((hash << 5) &+ hash) &+ value.valueHash
        return hash
    }
}
