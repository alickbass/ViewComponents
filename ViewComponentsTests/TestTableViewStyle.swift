//
//  TestTableViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestTableViewStyle: XCTestCase {
    let blur = UIBlurEffect()
    
    static let allStyles: [TableViewStyle] = [
        .rowHeight(40), .separatorStyle(.singleLine), .separatorColor(.red), .separatorEffect(UIBlurEffect()),
        .separatorInset(.zero), .cellLayoutMarginsFollowReadableWidth(true), .sectionHeaderHeight(40),
        .sectionFooterHeight(40), .estimatedRowHeight(40), .estimatedSectionHeaderHeight(40),
        .estimatedSectionFooterHeight(40), .allowsSelection(true), .allowsMultipleSelection(true),
        .allowsSelectionDuringEditing(true), .allowsMultipleSelectionDuringEditing(true), .isEditing(true),
        .sectionIndexColor(.red), .sectionIndexBackgroundColor(.red), .sectionIndexTrackingBackgroundColor(.red),
        .remembersLastFocusedIndexPath(true), .separatorColor(nil), .separatorEffect(nil), .sectionIndexColor(nil),
        .sectionIndexBackgroundColor(nil), .sectionIndexTrackingBackgroundColor(nil)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUIScrollViewStyle.accumulatedHashes + TestTableViewStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(TableViewStyle.rowHeight(40), .rowHeight(40))
        XCTAssertEqual(TableViewStyle.separatorStyle(.singleLine), .separatorStyle(.singleLine))
        XCTAssertEqual(TableViewStyle.separatorColor(.red), .separatorColor(.red))
        XCTAssertEqual(TableViewStyle.separatorEffect(blur), .separatorEffect(blur))
        XCTAssertEqual(TableViewStyle.separatorInset(.zero), .separatorInset(.zero))
        XCTAssertEqual(TableViewStyle.cellLayoutMarginsFollowReadableWidth(true), .cellLayoutMarginsFollowReadableWidth(true))
        XCTAssertEqual(TableViewStyle.sectionHeaderHeight(40), .sectionHeaderHeight(40))
        XCTAssertEqual(TableViewStyle.sectionFooterHeight(40), .sectionFooterHeight(40))
        XCTAssertEqual(TableViewStyle.estimatedRowHeight(40), .estimatedRowHeight(40))
        XCTAssertEqual(TableViewStyle.estimatedSectionHeaderHeight(40), .estimatedSectionHeaderHeight(40))
        XCTAssertEqual(TableViewStyle.estimatedSectionFooterHeight(40), .estimatedSectionFooterHeight(40))
        XCTAssertEqual(TableViewStyle.allowsSelection(true), .allowsSelection(true))
        XCTAssertEqual(TableViewStyle.allowsMultipleSelection(true), .allowsMultipleSelection(true))
        XCTAssertEqual(TableViewStyle.allowsSelectionDuringEditing(true), .allowsSelectionDuringEditing(true))
        XCTAssertEqual(TableViewStyle.allowsMultipleSelectionDuringEditing(true), .allowsMultipleSelectionDuringEditing(true))
        XCTAssertEqual(TableViewStyle.isEditing(true), .isEditing(true))
        XCTAssertEqual(TableViewStyle.sectionIndexColor(.red), .sectionIndexColor(.red))
        XCTAssertEqual(TableViewStyle.sectionIndexBackgroundColor(.red), .sectionIndexBackgroundColor(.red))
        XCTAssertEqual(TableViewStyle.sectionIndexTrackingBackgroundColor(.red), .sectionIndexTrackingBackgroundColor(.red))
        XCTAssertEqual(TableViewStyle.remembersLastFocusedIndexPath(true), .remembersLastFocusedIndexPath(true))
        XCTAssertNotEqual(TableViewStyle.remembersLastFocusedIndexPath(true), .sectionIndexTrackingBackgroundColor(.red))
    }
    
    func testStyleSideEffects() {
        let view = UITableView()
        
        view.rowHeight = 50
        TableViewStyle.rowHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.rowHeight, 40)
        
        view.separatorStyle = .none
        TableViewStyle.separatorStyle(.singleLine).sideEffect(on: view)
        XCTAssertEqual(view.separatorStyle, .singleLine)
        
        view.separatorColor = nil
        TableViewStyle.separatorColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.separatorColor, .red)
        
        view.separatorEffect = nil
        TableViewStyle.separatorEffect(blur).sideEffect(on: view)
        XCTAssertNotNil(view.separatorEffect)
        
        view.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        TableViewStyle.separatorInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.separatorInset, .zero)
        
        view.cellLayoutMarginsFollowReadableWidth = false
        TableViewStyle.cellLayoutMarginsFollowReadableWidth(true).sideEffect(on: view)
        XCTAssertEqual(view.cellLayoutMarginsFollowReadableWidth, true)
        
        view.sectionHeaderHeight = 30
        TableViewStyle.sectionHeaderHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.sectionHeaderHeight, 40)
        
        view.sectionFooterHeight = 30
        TableViewStyle.sectionFooterHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.sectionFooterHeight, 40)
        
        view.estimatedRowHeight = 30
        TableViewStyle.estimatedRowHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedRowHeight, 40)
        
        view.estimatedSectionHeaderHeight = 30
        TableViewStyle.estimatedSectionHeaderHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedSectionHeaderHeight, 40)
        
        view.estimatedSectionFooterHeight = 30
        TableViewStyle.estimatedSectionFooterHeight(40).sideEffect(on: view)
        XCTAssertEqual(view.estimatedSectionFooterHeight, 40)
        
        view.allowsSelection = false
        TableViewStyle.allowsSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelection, true)
        
        view.allowsMultipleSelection = false
        TableViewStyle.allowsMultipleSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelection, true)
        
        view.allowsSelectionDuringEditing = false
        TableViewStyle.allowsSelectionDuringEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelectionDuringEditing, true)
        
        view.allowsMultipleSelectionDuringEditing = false
        TableViewStyle.allowsMultipleSelectionDuringEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelectionDuringEditing, true)
        
        view.isEditing = false
        TableViewStyle.isEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditing, true)
        
        view.sectionIndexColor = nil
        TableViewStyle.sectionIndexColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexColor, .red)
        
        view.sectionIndexBackgroundColor = nil
        TableViewStyle.sectionIndexBackgroundColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexBackgroundColor, .red)
        
        view.sectionIndexTrackingBackgroundColor = nil
        TableViewStyle.sectionIndexTrackingBackgroundColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.sectionIndexTrackingBackgroundColor, .red)
        
        view.remembersLastFocusedIndexPath = false
        TableViewStyle.remembersLastFocusedIndexPath(true).sideEffect(on: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
        
        view.remembersLastFocusedIndexPath = false
        Component<UITableView>().tableViewStyles(.remembersLastFocusedIndexPath(true)).configure(view: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
    }
    
    func testHashValue() {
        var hashes = Set(TestUIScrollViewStyle.accumulatedHashes)
        
        for item in TestTableViewStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
