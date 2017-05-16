//
//  TestComponent.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
@testable import ViewComponents

class TestComponent: XCTestCase {
    let comp = Component<UIView>().view(.alpha(0.2), .backgroundColor(.red))
    let viewAccess: (UIView) -> UIView = { $0 }
    let buttonAccess: (UIView) -> UIButton = { _ in UIButton() }
    let labelAcess: (UIView) -> UILabel = { _ in UILabel() }
    
    func testComponentEquatable() {
        XCTAssertEqual(comp, comp)
        XCTAssertEqual(comp.view(.alpha(0.2), .backgroundColor(.red)), comp)
        XCTAssertEqual(Component<UIView>().view(.backgroundColor(.red), .alpha(0.2)), comp)
        XCTAssertEqual(comp.child(comp, viewAccess), comp.child(comp, viewAccess))
        XCTAssertNotEqual(comp.child(comp, { $0 }), comp.child(Component<UILabel>(), labelAcess))
    }
    
    func testComponentSideEffect() {
        let view = UIView()
        let label = UILabel()
        let labelComp = Component<UILabel>().label(.isEnabled(false))

        comp.child(labelComp, { _ in label }).configure(view: view)
        
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
        XCTAssertEqual(label.isEnabled, false)
    }
    
    func testComponentConvertibleProtocol() {
        struct MyViewModel: ComponentConvertible {
            var toComponent: Component<UIView> {
                return Component<UIView>().view(.alpha(0.2), .backgroundColor(.red))
            }
        }
        
        XCTAssertEqual(comp.toComponent, comp)
        
        let view = UIView()
        MyViewModel().configure(view: view)
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
    }
    
    func testChildComponent() {
        let child = ChildComponent(component: comp, viewAccess)
        XCTAssertEqual(child.styles, comp.styles)
        XCTAssertTrue(child.isEqual(to: child))
        XCTAssertFalse(child.isEqual(to: comp))
    }
    
    func testComponentDiffing() {
        XCTAssertEqual(Component<UIView>().view(.alpha(0.2)).diffChanges(from: comp), Component<UIView>().view(.backgroundColor(.red)))
        
        let firstComponent = Component<UIView>()
            .view(.clipsToBounds(true), .backgroundColor(.red))
            .child(
                Component<UIView>()
                    .border(.color(.red), .width(12))
                    .view(.isHidden(true)), viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.title("test", for: .normal))
                    .view(.isHidden(true)), buttonAccess
            )
            .child(Component<UILabel>().label(.isEnabled(true)), labelAcess)
        
        let secondComponent = Component<UIView>()
            .view(.backgroundColor(.red), .contentMode(.bottom))
            .child(
                Component<UIView>()
                    .border(.color(.green), .width(12))
                    .view(.isHidden(true)), viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.title("test", for: .normal), .titleColor(.red, for: .normal))
                    .view(.isHidden(true), .isMultipleTouchEnabled(true)), buttonAccess
            )
            .child(Component<UILabel>().label(.isEnabled(true)), labelAcess)
            .child(Component<UIView>().view(.clearsContextBeforeDrawing(true)), viewAccess)
        
        let diff = Component<UIView>()
            .view(.contentMode(.bottom))
            .child(
                Component<UIView>()
                    .border(.color(.green))
                    .view(), viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.titleColor(.red, for: .normal))
                    .view(.isMultipleTouchEnabled(true)), buttonAccess
            )
            .child(Component<UIView>().view(.clearsContextBeforeDrawing(true)), viewAccess)
        
        XCTAssertEqual(firstComponent.diffChanges(from: secondComponent), diff)
        XCTAssertEqual(Component<UIView>().child(Component<UIView>(), viewAccess).children.first?.isEmpty, true)
        XCTAssertTrue(comp.diffChanges(from: Component<UIButton>()).isEqual(to: Component<UIButton>()))
    }
    
}
