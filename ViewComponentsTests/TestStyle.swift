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
    
    func testStyleDescription() {
        XCTAssertEqual(AnyStyle<UILabel>.adjustsFontSizeToFitWidth(true).description, "adjustsFontSizeToFitWidth: true")
        XCTAssertEqual(AnyStyle<UIView>.backgroundColor(nil).description, "backgroundColor: nil")
    }
    
    func testCustomSideEffect() {
        let view = UIView()
        let style = AnyStyle<UIView>.style(for: "hidden", with: true, sideEffect: { $0.view.isHidden = $0.input })
        
        view.isHidden = false
        style.sideEffect(on: view)
        XCTAssertEqual(view.isHidden, true)
        
        let backColor = AnyStyle<UIView>.style(for: "backColor", with: UIColor?.some(.green), sideEffect: { $0.view.backgroundColor = $0.input })
        
        view.backgroundColor = .red
        backColor.sideEffect(on: view)
        XCTAssertEqual(view.backgroundColor, .green)
        
        XCTAssertEqual(style, .style(for: "hidden", with: true, sideEffect: { $0.view.isHidden = $0.input }))
        XCTAssertEqual(style.hashValue, AnyStyle<UIView>.style(for: "hidden", with: true, sideEffect: { $0.view.isHidden = $0.input }).hashValue)
    }
}
