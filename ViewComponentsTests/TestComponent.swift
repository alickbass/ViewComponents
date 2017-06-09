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
        XCTAssertEqual(comp.child(viewAccess, comp), comp.child(viewAccess, comp))
        XCTAssertNotEqual(comp.child({ $0 }, comp), comp.child(labelAcess, Component<UILabel>()))
    }
    
    func testComponentSideEffect() {
        let view = UIView()
        let label = UILabel()
        let labelComp = Component<UILabel>().label(.isEnabled(false))

        comp.child({ _ in label }, labelComp).configure(item: view)
        
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
        MyViewModel().configure(item: view)
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
        
        XCTAssertEqual(Component().diffChanges(from: MyViewModel()), MyViewModel().toComponent)
    }
    
    func testChildComponent() {
        let child = ChildComponent(component: comp, viewAccess)
        let otherChild = ChildComponent(component: Component<UIButton>(), { (view: UIView) -> UIButton in UIButton() })
        XCTAssertEqual(child.diffChanges(from: otherChild), otherChild)
        XCTAssertEqual(child.children, comp.children)
        XCTAssertEqual(ChildComponent(component: comp.child(viewAccess, comp), viewAccess).children, comp.child(viewAccess, comp).children)
    }
    
    func testComponentDiffing() {
        XCTAssertEqual(Component<UIView>().view(.alpha(0.2)).diffChanges(from: comp), Component<UIView>().view(.backgroundColor(.red)))
        
        let firstComponent = Component<UIView>()
            .view(.clipsToBounds(true), .backgroundColor(.red))
            .child(viewAccess,
                Component<UIView>()
                    .border(.color(.red), .width(12))
                    .view(.isHidden(true))
            )
            .child(buttonAccess,
                Component<UIButton>()
                    .button(.title("test", for: .normal))
                    .view(.isHidden(true))
            )
            .child(labelAcess, Component<UILabel>().label(.isEnabled(true)))
        
        let secondComponent = Component<UIView>()
            .view(.backgroundColor(.red), .contentMode(.bottom))
            .child(viewAccess,
                Component<UIView>()
                    .border(.color(.green), .width(12))
                    .view(.isHidden(true))
            )
            .child(buttonAccess,
                Component<UIButton>()
                    .button(.title("test", for: .normal), .titleColor(.red, for: .normal))
                    .view(.isHidden(true), .isMultipleTouchEnabled(true))
            )
            .child(labelAcess, Component<UILabel>().label(.isEnabled(true)))
            .child(viewAccess, Component<UIView>().view(.clearsContextBeforeDrawing(true)))
        
        let diff = Component<UIView>()
            .view(.contentMode(.bottom))
            .child(viewAccess,
                Component<UIView>()
                    .border(.color(.green))
                    .view()
            )
            .child(buttonAccess,
                Component<UIButton>()
                    .button(.titleColor(.red, for: .normal))
                    .view(.isMultipleTouchEnabled(true))
            )
            .child(viewAccess, Component<UIView>().view(.clearsContextBeforeDrawing(true)))
        
        XCTAssertEqual(firstComponent.diffChanges(from: secondComponent), diff)
        XCTAssertEqual(Component<UIView>().child(viewAccess, Component<UIView>()).children.first?.isEmpty, true)
//        XCTAssertTrue(comp.diffChanges(from: Component<UIButton>()).isEqual(to: Component<UIButton>()))
    }
    
}
