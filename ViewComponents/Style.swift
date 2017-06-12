//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 12/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public struct Style<View, Input, Key: RawRepresentable>: StyleType where Key.RawValue == Int {
    public let input: Input
    public let key: Key
    public let sideEffect: (View, Input) -> Void
    public let equality: (Input, Input) -> Bool
    public let hash: (Input) -> Int
    
    public init(_ input: Input, key: Key, sideEffect: @escaping (View, Input) -> Void, equality: @escaping (Input, Input) -> Bool, hash: @escaping (Input) -> Int) {
        self.input = input
        self.key = key
        self.sideEffect = sideEffect
        self.equality = equality
        self.hash = hash
    }
    
    public func sideEffect(on item: View) {
        sideEffect(item, input)
    }
    
    public static func == (lhs: Style<View, Input, Key>, rhs: Style<View, Input, Key>) -> Bool {
        return lhs.equality(lhs.input, rhs.input)
    }
    
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ key.rawValue.hashValue
        hash = ((hash << 5) &+ hash) &+ self.hash(input)
        return hash
    }
    
    public var toAnyStyle: AnyStyle<View> {
        return AnyStyle<View>(self)
    }
}

extension Style where Input: Equatable {
    public init(_ input: Input, key: Key, sideEffect: @escaping (View, Input) -> Void, hash: @escaping (Input) -> Int) {
        self.init(input, key: key, sideEffect: sideEffect, equality: { $0.0 == $0.1 }, hash: hash)
    }
}

extension Style where Input: Hashable {
    public init(_ input: Input, key: Key, sideEffect: @escaping (View, Input) -> Void) {
        self.init(input, key: key, sideEffect: sideEffect, hash: { $0.hashValue })
    }
}
