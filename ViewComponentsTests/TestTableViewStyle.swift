//
//  TestTableViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
}

class TestTableViewStyle: XCTestCase, ViewTestType {
    let blur = UIBlurEffect()
    let controller = TableViewController()
    
    static let allStyles: [AnyStyle<UITableView>] = [
        .rowHeight(40), .separatorStyle(.singleLine), .separatorColor(.red), .separatorEffect(UIBlurEffect()),
        .separatorInset(.zero), .cellLayoutMarginsFollowReadableWidth(true), .sectionHeaderHeight(40),
        .sectionFooterHeight(40), .estimatedRowHeight(40), .estimatedSectionHeaderHeight(40),
        .estimatedSectionFooterHeight(40), .allowsSelection(true), .allowsMultipleSelection(true),
        .allowsSelectionDuringEditing(true), .allowsMultipleSelectionDuringEditing(true), .isEditing(true),
        .sectionIndexColor(.red), .sectionIndexBackgroundColor(.red), .sectionIndexTrackingBackgroundColor(.red),
        .remembersLastFocusedIndexPath(true), .separatorColor(nil), .separatorEffect(nil), .sectionIndexColor(nil),
        .sectionIndexBackgroundColor(nil), .sectionIndexTrackingBackgroundColor(nil),
        .dataSource(nil), .dataSource(TableViewController()), .delegate(nil), .delegate(TableViewController()),
        .tableHeaderView(UIView()), .tableFooterView(UIView())
    ]
    
    static var previousHashes: [Int : Any] { return TestUIScrollViewStyle.accumulatedHashes }
    
    func testAnyStyleEquatable() {
        XCTAssertEqual(AnyStyle<UITableView>.dataSource(controller), .dataSource(controller))
        XCTAssertEqual(AnyStyle<UITableView>.delegate(controller), .delegate(controller))
    }
    
    func testAnyStyleSideEffects() {
        let view = UITableView()
        
        view.rowHeight = 50
        AnyStyle<UITableView>.rowHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.rowHeight, 40)
        
        view.separatorStyle = .none
        AnyStyle<UITableView>.separatorStyle(.singleLine).sideEffect(on: view)
        XCTAssertEqual(view.separatorStyle, .singleLine)
        
        view.separatorColor = nil
        AnyStyle<UITableView>.separatorColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.separatorColor, .red)
        
        view.separatorEffect = nil
        AnyStyle<UITableView>.separatorEffect(blur).sideEffect(on: view)
        XCTAssertNotNil(view.separatorEffect)
        
        view.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        AnyStyle<UITableView>.separatorInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.separatorInset, .zero)
        
        view.cellLayoutMarginsFollowReadableWidth = false
        AnyStyle<UITableView>.cellLayoutMarginsFollowReadableWidth(true).sideEffect(on: view)
        XCTAssertEqual(view.cellLayoutMarginsFollowReadableWidth, true)
        
        view.sectionHeaderHeight = 30
        AnyStyle<UITableView>.sectionHeaderHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.sectionHeaderHeight, 40)
        
        view.sectionFooterHeight = 30
        AnyStyle<UITableView>.sectionFooterHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.sectionFooterHeight, 40)
        
        view.estimatedRowHeight = 30
        AnyStyle<UITableView>.estimatedRowHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedRowHeight, 40)
        
        view.estimatedSectionHeaderHeight = 30
        AnyStyle<UITableView>.estimatedSectionHeaderHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedSectionHeaderHeight, 40)
        
        view.estimatedSectionFooterHeight = 30
        AnyStyle<UITableView>.estimatedSectionFooterHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedSectionFooterHeight, 40)
        
        view.allowsSelection = false
        AnyStyle<UITableView>.allowsSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelection, true)
        
        view.allowsMultipleSelection = false
        AnyStyle<UITableView>.allowsMultipleSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelection, true)
        
        view.allowsSelectionDuringEditing = false
        AnyStyle<UITableView>.allowsSelectionDuringEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelectionDuringEditing, true)
        
        view.allowsMultipleSelectionDuringEditing = false
        AnyStyle<UITableView>.allowsMultipleSelectionDuringEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelectionDuringEditing, true)
        
        view.isEditing = false
        AnyStyle<UITableView>.isEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditing, true)
        
        view.sectionIndexColor = nil
        AnyStyle<UITableView>.sectionIndexColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexColor, .red)
        
        view.sectionIndexBackgroundColor = nil
        AnyStyle<UITableView>.sectionIndexBackgroundColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexBackgroundColor, .red)
        
        view.sectionIndexTrackingBackgroundColor = nil
        AnyStyle<UITableView>.sectionIndexTrackingBackgroundColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexTrackingBackgroundColor, .red)
        
        view.remembersLastFocusedIndexPath = false
        AnyStyle<UITableView>.remembersLastFocusedIndexPath(true).sideEffect(on: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
        
        view.dataSource = nil
        AnyStyle<UITableView>.dataSource(controller).sideEffect(on: view)
        XCTAssertTrue(view.dataSource === controller)
        
        view.delegate = nil
        AnyStyle<UITableView>.delegate(controller).sideEffect(on: view)
        XCTAssertTrue(view.delegate === controller)
        
        
        let customView = UIView()
        
        view.tableHeaderView = nil
        AnyStyle<UITableView>.tableHeaderView(customView).sideEffect(on: view)
        XCTAssertEqual(view.tableHeaderView, customView)
        
        view.tableFooterView = nil
        AnyStyle<UITableView>.tableFooterView(customView).sideEffect(on: view)
        XCTAssertEqual(view.tableFooterView, customView)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
