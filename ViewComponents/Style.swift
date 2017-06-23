//
//  Style.swift
//  ViewComponents
//
//  Created by Oleksii on 12/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

protocol StyleKey {
    var hashValue: Int { get }
}

extension StyleKey where Self: RawRepresentable, Self.RawValue == Int {
    var hashValue: Int {
        return rawValue.hashValue
    }
}

public struct Style<View, Input, Key: Hashable>: StyleType {
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
        return lhs.key == rhs.key && lhs.equality(lhs.input, rhs.input)
    }
    
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ key.hashValue
        hash = ((hash << 5) &+ hash) &+ self.hash(input)
        return hash
    }
    
    public var toAnyStyle: AnyStyle<View> {
        return AnyStyle<View>(self)
    }
}

extension Style where Input: Hashable {
    public init(_ input: Input, key: Key, sideEffect: @escaping (View, Input) -> Void) {
        self.init(input, key: key, sideEffect: sideEffect, equality: { $0.0 == $0.1 }, hash: { $0.hashValue })
    }
}

extension Style where Input: Optionable, Input.WrappedType: Hashable {
    public init(_ input: Input, key: Key, sideEffect: @escaping (View, Input) -> Void) {
        self.init(input, key: key, sideEffect: sideEffect, equality: { $0.value == $1.value }, hash: { $0.value?.hashValue ?? 0 })
    }
}

extension Style: CustomStringConvertible {
    public var description: String {
        return "\(key): \(input)"
    }
}

public extension AnyStyle {
    public static func style<K: Hashable, I: Hashable>(with input: I, for key: K, sideEffect: @escaping ((view: T, input: I)) -> Void) -> AnyStyle<T> {
        return Style<T, I, K>(input, key: key, sideEffect: sideEffect).toAnyStyle
    }
}
