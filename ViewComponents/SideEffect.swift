//
//  SideEffect.swift
//  ViewComponents
//
//  Created by Oleksii on 22/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

struct SideEffectStyle<Key: Hashable, View>: StyleType {
    let key: Key
    let sideEffect: (View) -> Void
    
    func sideEffect(on item: View) {
        sideEffect(item)
    }
    
    var hashValue: Int {
        return key.hashValue
    }
    
    static func == (lhs: SideEffectStyle<Key, View>, rhs: SideEffectStyle<Key, View>) -> Bool {
        return lhs.key == rhs.key
    }
}

public extension AnyStyle {
    public static func sideEffect<Key: Hashable>(for key: Key, _ sideEffect: @escaping (T) -> Void) -> AnyStyle<T> {
        return AnyStyle(SideEffectStyle<Key, T>(key: key, sideEffect: sideEffect))
    }
}
