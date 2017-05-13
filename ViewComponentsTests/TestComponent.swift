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
    let comp = Component<UIView>().viewStyles(.alpha(0.2), .backgroundColor(.red))
    
    func testComponentEquatable() {
        XCTAssertEqual(comp, comp)
        XCTAssertEqual(comp.viewStyles(.alpha(0.2), .backgroundColor(.red)), comp)
        XCTAssertEqual(Component<UIView>().viewStyles(.backgroundColor(.red), .alpha(0.2)), comp)
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
    
    func testComponentConvertibleProtocol() {
        struct MyViewModel: ComponentConvertible {
            var toComponent: Component<UIView> {
                return Component<UIView>()
                    .viewStyles(
                        .alpha(0.2), .backgroundColor(.red)
                )
            }
        }
        
        XCTAssertEqual(comp.toComponent, comp)
        
        let view = UIView()
        MyViewModel().configure(view: view)
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
    }
    
    func testChildComponent() {
        let child = ChildComponent(component: comp, { _ in UIView() })
        XCTAssertEqual(child.styles, comp.styles)
        XCTAssertTrue(child.isEqual(to: child))
        XCTAssertFalse(child.isEqual(to: comp))
    }
    
    func testComponentDiffing() {
        let access: (UIView) -> UIView = { $0 }
        let button: (UIView) -> UIButton = { _ in UIButton() }
        XCTAssertEqual(Component<UIView>().viewStyles(.alpha(0.2)).diffChanges(from: comp), Component<UIView>().viewStyles(.backgroundColor(.red)))
        
        let firstComponent = Component<UIView>()
            .viewStyles(.clipsToBounds(true), .backgroundColor(.red))
            .child(
                Component<UIView>()
                    .borderStyles(.color(.red), .width(12))
                    .viewStyles(.isHidden(true)), access
            )
            .child(
                Component<UIButton>()
                    .buttonStyles(.title("test", for: .normal))
                    .viewStyles(.isHidden(true)), button
            )
        
        let secondComponent = Component<UIView>()
            .viewStyles(.backgroundColor(.red), .contentMode(.bottom))
            .child(
                Component<UIView>()
                    .borderStyles(.color(.green), .width(12))
                    .viewStyles(.isHidden(true)), access
            )
            .child(
                Component<UIButton>()
                    .buttonStyles(.title("test", for: .normal), .titleColor(.red, for: .normal))
                    .viewStyles(.isHidden(true), .isMultipleTouchEnabled(true)), button
            )
            .child(Component<UIView>().viewStyles(.clearsContextBeforeDrawing(true)), access)
        
        let diff = Component<UIView>()
            .viewStyles(.contentMode(.bottom))
            .child(
                Component<UIView>()
                    .borderStyles(.color(.green))
                    .viewStyles(), access
            )
            .child(
                Component<UIButton>()
                    .buttonStyles(.titleColor(.red, for: .normal))
                    .viewStyles(.isMultipleTouchEnabled(true)), button
            )
            .child(Component<UIView>().viewStyles(.clearsContextBeforeDrawing(true)), access)
        
        XCTAssertEqual(firstComponent.diffChanges(from: secondComponent), diff)
        XCTAssertEqual(Component<UIView>().child(Component<UIView>(), access).children.first?.isEmpty, true)
        XCTAssertTrue(comp.diffChanges(from: Component<UIButton>()).isEqual(to: Component<UIButton>()))
    }
    
}
