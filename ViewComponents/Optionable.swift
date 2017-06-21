//
//  Optionable.swift
//  ViewComponents
//
//  Created by Oleksii on 12/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import Foundation

public protocol Optionable {
    associatedtype WrappedType
    var value: WrappedType? { get }
}

extension Optional : Optionable {
    public typealias WrappedType = Wrapped
    
    public var value: WrappedType? {
        return self
    }
    
    var _description: String {
        return value.map({ "\($0)" }) ?? "nil"
    }
}
