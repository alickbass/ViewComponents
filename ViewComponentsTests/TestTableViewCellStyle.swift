//
//  TestTableViewCellStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestTableViewCellStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UITableViewCell>] = [
        AnyStyle<UITableViewCell>.accessoryType(.detailButton), AnyStyle<UITableViewCell>.editingAccessoryType(.detailButton),
        AnyStyle<UITableViewCell>.isSelected(true), AnyStyle<UITableViewCell>.selectionStyle(.gray), AnyStyle<UITableViewCell>.isHighlighted(true),
        AnyStyle<UITableViewCell>.isEditing(true), AnyStyle<UITableViewCell>.showsReorderControl(true),
        AnyStyle<UITableViewCell>.indentationLevel(3), AnyStyle<UITableViewCell>.indentationWidth(3), AnyStyle<UITableViewCell>.shouldIndentWhileEditing(true),
        AnyStyle<UITableViewCell>.separatorInset(.zero), AnyStyle<UITableViewCell>.focusStyle(.default)
    ]
    
    static var previousHashes: [Int : Any] { return TestTableViewStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UITableViewCell()
        
        view.accessoryType = .checkmark
        AnyStyle<UITableViewCell>.accessoryType(.detailButton).sideEffect(on: view)
        XCTAssertEqual(view.accessoryType, .detailButton)
        
        view.editingAccessoryType = .checkmark
        AnyStyle<UITableViewCell>.editingAccessoryType(.detailButton).sideEffect(on: view)
        XCTAssertEqual(view.editingAccessoryType, .detailButton)
        
        view.isSelected = false
        AnyStyle<UITableViewCell>.isSelected(true).sideEffect(on: view)
        XCTAssertEqual(view.isSelected, true)
        
        view.selectionStyle = .blue
        AnyStyle<UITableViewCell>.selectionStyle(.gray).sideEffect(on: view)
        XCTAssertEqual(view.selectionStyle, .gray)
        
        view.isHighlighted = false
        AnyStyle<UITableViewCell>.isHighlighted(true).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, true)
        
        view.isEditing = false
        AnyStyle<UITableViewCell>.isEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditing, true)
        
        view.showsReorderControl = false
        AnyStyle<UITableViewCell>.showsReorderControl(true).sideEffect(on: view)
        XCTAssertEqual(view.showsReorderControl, true)
        
        view.indentationLevel = 2
        AnyStyle<UITableViewCell>.indentationLevel(3).sideEffect(on: view)
        XCTAssertEqual(view.indentationLevel, 3)
        
        view.indentationWidth = 2
        AnyStyle<UITableViewCell>.indentationWidth(3).sideEffect(on: view)
        XCTAssertEqual(view.indentationWidth, 3)
        
        view.shouldIndentWhileEditing = false
        AnyStyle<UITableViewCell>.shouldIndentWhileEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.shouldIndentWhileEditing, true)
        
        view.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        AnyStyle<UITableViewCell>.separatorInset(.zero).sideEffect(on: view)
        XCTAssertNotEqual(view.separatorInset, UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        view.focusStyle = .custom
        AnyStyle<UITableViewCell>.focusStyle(.default).sideEffect(on: view)
        XCTAssertEqual(view.focusStyle, .default)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
