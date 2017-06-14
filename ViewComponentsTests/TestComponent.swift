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
    let comp = Component<UIView>(.alpha(0.2), .backgroundColor(.red))
    let viewAccess: (UIView) -> UIView = { $0 }
    let buttonAccess: (UIView) -> UIButton = { _ in UIButton() }
    let labelAcess: (UIView) -> UILabel = { _ in UILabel() }

    func testComponentEquatable() {
        XCTAssertEqual(comp, comp)
        XCTAssertEqual(comp.adding(.alpha(0.2), .backgroundColor(.red)), comp)
        XCTAssertEqual(Component<UIView>(.backgroundColor(.red), .alpha(0.2)), comp)
        XCTAssertEqual(comp.withChildren(.child(viewAccess, comp)), comp.withChildren(.child(viewAccess, comp)))
        XCTAssertNotEqual(comp.withChildren(.child({ $0 }, comp)), comp.withChildren(.child(labelAcess, Component<UILabel>())))
    }

    func testComponentSideEffect() {
        let view = UIView()
        let label = UILabel()
        let labelComp = Component<UILabel>(.isEnabled(false))

        comp.withChildren(.child({ _ in label }, labelComp)).configure(item: view)

        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.backgroundColor, .red)
        XCTAssertEqual(label.isEnabled, false)
    }

    func testComponentConvertibleProtocol() {
        struct MyViewModel: ComponentConvertible {
            var toComponent: Component<UIView> {
                return Component<UIView>(.alpha(0.2), .backgroundColor(.red))
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
        XCTAssertEqual(ChildComponent(component: comp.withChildren(.child(viewAccess, comp)), viewAccess).children, comp.withChildren(.child(viewAccess, comp)).children)
    }

    func testComponentDiffing() {
        XCTAssertEqual(Component<UIView>(.alpha(0.2)).diffChanges(from: comp), Component<UIView>(.backgroundColor(.red)))

        let firstComponent = Component<UIView>(
            .clipsToBounds(true), .backgroundColor(.red)
        )
        .withChildren(
            .child(viewAccess, styles:
                .border(width: 12, color: .red), .isHidden(true)
            ),
            .child(buttonAccess, styles:
                .title("test", for: .normal), .isHidden(true)
            ),
            .child(labelAcess, styles:
                .isEnabled(true)
            )
        )
        
        let secondComponent = Component<UIView>(
            .backgroundColor(.red), .contentMode(.bottom)
        )
        .withChildren(
            .child(viewAccess, styles:
                .border(width: 12, color: .green), .isHidden(true)
            ),
            .child(buttonAccess, styles:
                .title("test"), .titleColor(.red),
                .isHidden(true), .isMultipleTouchEnabled(true)
            ),
            .child(labelAcess, styles:
                .isEnabled(true)
            ),
            .child(viewAccess, Component<UIView>(.clearsContextBeforeDrawing(true)))
        )
        
        let diff = Component<UIView>(
            .contentMode(.bottom)
        )
        .withChildren(
            .child(viewAccess, styles:
                .border(width: 12, color: .green)
            ),
            .child(buttonAccess, styles:
                .titleColor(.red),
                .isMultipleTouchEnabled(true)
            ),
            .child(viewAccess, styles:
                .clearsContextBeforeDrawing(true)
            )
        )

        XCTAssertEqual(firstComponent.diffChanges(from: secondComponent), diff)
        XCTAssertEqual(Component<UIView>().withChildren(.child(viewAccess, Component<UIView>())).children.first?.isEmpty, true)
    }
    
    func testComponentViewType() {
        class CustomView: UIView, ComponentContainingView {
            var item: Component<CustomView>?
        }

        let component = Component<CustomView>(.alpha(0.2))
        let view = CustomView()

        view.configure(with: component)
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.item, component)

        let new = component.adding(.isHidden(true))

        view.configure(with: new)
        XCTAssertEqualWithAccuracy(view.alpha, 0.2, accuracy: 0.001)
        XCTAssertEqual(view.isHidden, true)
        XCTAssertEqual(view.item, new)
    }
    
}
