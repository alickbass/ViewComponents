//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public protocol StyleType {
    func sideEffect(view: UIView)
    func isEqual(to other: StyleType) -> Bool
}

public protocol ConcreteStyleType: StyleType, Equatable {
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
