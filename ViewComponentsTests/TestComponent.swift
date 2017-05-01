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
    
    func testComponentEquatable() {
        let comp = Component<UIView>().viewStyles(.alpha(0.2), .backgroundColor(.red))
        XCTAssertEqual(comp, comp)
        XCTAssertEqual(comp.child(comp, { $0 }), comp.child(comp, { $0 }))
        XCTAssertNotEqual(comp.child(comp, { $0 }), comp.child(Component<UILabel>(), { _ in UILabel() }))
    }
    
}
