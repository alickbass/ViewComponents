//
//  TestStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestStyle: XCTestCase {
    
    func testStyleEquatable() {
        XCTAssertTrue(UIViewStyle.isHidden(true).isEqual(to: UIViewStyle.isHidden(true)))
        XCTAssertFalse(UIViewStyle.isHidden(true).isEqual(to: UIViewStyle.isHidden(false)))
        XCTAssertFalse(UIViewStyle.isHidden(true).isEqual(to: UILabelStyle.font(.boldSystemFont(ofSize: 12))))
    }
    
    func testStyleSideEffect() {
        let view = UIView()
        
        view.backgroundColor = .red
        UIViewStyle.backgroundColor(.green).sideEffect(view: view)
        XCTAssertEqual(view.backgroundColor, .green)
    }
    
}
