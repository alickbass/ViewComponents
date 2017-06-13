//
//  TestStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/06/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class MyView {
    enum Key: Int {
        case one, two
    }
    
    enum OtherKey: Int {
        case alpha
    }
    
    var one: Int = 0
    var two: Int? = .none
}

class TestStyle: XCTestCase {
    
    func testStyleHashableInput() {
        let style = Style<MyView, Int, MyView.Key>(4, key: .one, sideEffect: { $0.one = $1 })
        let optional = Style<MyView, Int?, MyView.Key>(4, key: .two, sideEffect: { $0.two = $1 })
        
        XCTAssertEqual(style, .init(4, key: .one, sideEffect: { $0.one = $1 }))
        XCTAssertNotEqual(style, .init(5, key: .one, sideEffect: { $0.one = $1 }))
        XCTAssertNotEqual(style, .init(4, key: .two, sideEffect: { $0.one = $1 }))
        XCTAssertNotEqual(style.toAnyStyle, Style<MyView, Int, MyView.OtherKey>(4, key: .alpha, sideEffect: { $0.one = $1 }).toAnyStyle)
        XCTAssertEqual(style.hashValue, Style<MyView, Int, MyView.Key>(4, key: .one, sideEffect: { $0.one = $1 }).hashValue)
        XCTAssertNotEqual(style.hashValue, Style<MyView, Int, MyView.Key>(4, key: .two, sideEffect: { $0.one = $1 }).hashValue)
        
        XCTAssertEqual(optional, .init(4, key: .two, sideEffect: { $0.two = $1 }))
        XCTAssertEqual(optional.hashValue, Style<MyView, Int?, MyView.Key>(4, key: .two, sideEffect: { $0.two = $1 }).hashValue)
        XCTAssertNotEqual(optional.hashValue, Style<MyView, Int?, MyView.Key>(.none, key: .two, sideEffect: { $0.two = $1 }).hashValue)
    }
}
