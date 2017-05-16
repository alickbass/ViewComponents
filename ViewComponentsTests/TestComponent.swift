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
        XCTAssertEqual(comp.child(comp, access: viewAccess), comp.child(comp, access: viewAccess))
        XCTAssertNotEqual(comp.child(comp, access: { $0 }), comp.child(Component<UILabel>(), access: labelAcess))
    }
    
    func testComponentSideEffect() {
        let view = UIView()
        let label = UILabel()
        let labelComp = Component<UILabel>().label(.isEnabled(false))

        comp.child(labelComp, access: { _ in label }).configure(view: view)
        
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
                    .view(.isHidden(true)),
                access: viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.title("test", for: .normal))
                    .view(.isHidden(true)),
                access: buttonAccess
            )
            .child(Component<UILabel>().label(.isEnabled(true)), access: labelAcess)
        
        let secondComponent = Component<UIView>()
            .view(.backgroundColor(.red), .contentMode(.bottom))
            .child(
                Component<UIView>()
                    .border(.color(.green), .width(12))
                    .view(.isHidden(true)), access: viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.title("test", for: .normal), .titleColor(.red, for: .normal))
                    .view(.isHidden(true), .isMultipleTouchEnabled(true)),
                access: buttonAccess
            )
            .child(Component<UILabel>().label(.isEnabled(true)), access: labelAcess)
            .child(Component<UIView>().view(.clearsContextBeforeDrawing(true)), access: viewAccess)
        
        let diff = Component<UIView>()
            .view(.contentMode(.bottom))
            .child(
                Component<UIView>()
                    .border(.color(.green))
                    .view(), access: viewAccess
            )
            .child(
                Component<UIButton>()
                    .button(.titleColor(.red, for: .normal))
                    .view(.isMultipleTouchEnabled(true)),
                access: buttonAccess
            )
            .child(Component<UIView>().view(.clearsContextBeforeDrawing(true)), access: viewAccess)
        
        XCTAssertEqual(firstComponent.diffChanges(from: secondComponent), diff)
        XCTAssertEqual(Component<UIView>().child(Component<UIView>(), access: viewAccess).children.first?.isEmpty, true)
        XCTAssertTrue(comp.diffChanges(from: Component<UIButton>()).isEqual(to: Component<UIButton>()))
    }
    
}
