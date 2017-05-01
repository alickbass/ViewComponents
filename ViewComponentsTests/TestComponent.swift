//
//  TestComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestComponent: XCTestCase {
    let comp = Component<UIView>().viewStyles(.alpha(0.2), .backgroundColor(.red))
    
    func testComponentEquatable() {
        XCTAssertEqual(comp, comp)
        XCTAssertEqual(comp.child(comp, { $0 }), comp.child(comp, { $0 }))
        XCTAssertNotEqual(comp.child(comp, { $0 }), comp.child(Component<UILabel>(), { _ in UILabel() }))
    }
    
    func testComponentSideEffect() {
        let view = UIView()
        let label = UILabel()
        let labelComp = Component<UILabel>().labelStyles(.isEnabled(false))

        comp.child(labelComp, { _ in label }).configure(view: view)
        
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
        XCTAssertEqual(label.isEnabled, false)
    }
    
}
