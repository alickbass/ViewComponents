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
    
    static let allStyles: [TableViewCellStyle<UITableViewCell>] = [
        TableViewCellStyle.accessoryType(.detailButton), TableViewCellStyle.editingAccessoryType(.detailButton),
        TableViewCellStyle.isSelected(true), TableViewCellStyle.selectionStyle(.gray), TableViewCellStyle.isHighlighted(true),
        TableViewCellStyle.isEditing(true), TableViewCellStyle.showsReorderControl(true),
        TableViewCellStyle.indentationLevel(3), TableViewCellStyle.indentationWidth(3), TableViewCellStyle.shouldIndentWhileEditing(true),
        TableViewCellStyle.separatorInset(.zero), TableViewCellStyle.focusStyle(.default)
    ]
    
    static var previousHashes: [Int : Any] { return TestTableViewStyle.accumulatedHashes }
    
    func testStyleEquatable() {
        XCTAssertEqual(TableViewCellStyle.accessoryType(.detailButton), .accessoryType(.detailButton))
        XCTAssertEqual(TableViewCellStyle.editingAccessoryType(.detailButton), .editingAccessoryType(.detailButton))
        XCTAssertEqual(TableViewCellStyle.isSelected(true), .isSelected(true))
        XCTAssertEqual(TableViewCellStyle.selectionStyle(.gray), .selectionStyle(.gray))
        XCTAssertEqual(TableViewCellStyle.isHighlighted(true), .isHighlighted(true))
        XCTAssertEqual(TableViewCellStyle.isEditing(true), .isEditing(true))
        XCTAssertEqual(TableViewCellStyle.showsReorderControl(true), .showsReorderControl(true))
        XCTAssertEqual(TableViewCellStyle.indentationLevel(3), .indentationLevel(3))
        XCTAssertEqual(TableViewCellStyle.indentationWidth(3), .indentationWidth(3))
        XCTAssertEqual(TableViewCellStyle.shouldIndentWhileEditing(true), .shouldIndentWhileEditing(true))
        XCTAssertEqual(TableViewCellStyle.separatorInset(.zero), .separatorInset(.zero))
        XCTAssertEqual(TableViewCellStyle.focusStyle(.default), .focusStyle(.default))
        XCTAssertNotEqual(TableViewCellStyle.focusStyle(.default), .separatorInset(.zero))
    }
    
    func testStyleSideEffects() {
        let view = UITableViewCell()
        
        view.accessoryType = .checkmark
        TableViewCellStyle.accessoryType(.detailButton).sideEffect(on: view)
        XCTAssertEqual(view.accessoryType, .detailButton)
        
        view.editingAccessoryType = .checkmark
        TableViewCellStyle.editingAccessoryType(.detailButton).sideEffect(on: view)
        XCTAssertEqual(view.editingAccessoryType, .detailButton)
        
        view.isSelected = false
        TableViewCellStyle.isSelected(true).sideEffect(on: view)
        XCTAssertEqual(view.isSelected, true)
        
        view.selectionStyle = .blue
        TableViewCellStyle.selectionStyle(.gray).sideEffect(on: view)
        XCTAssertEqual(view.selectionStyle, .gray)
        
        view.isHighlighted = false
        TableViewCellStyle.isHighlighted(true).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, true)
        
        view.isEditing = false
        TableViewCellStyle.isEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditing, true)
        
        view.showsReorderControl = false
        TableViewCellStyle.showsReorderControl(true).sideEffect(on: view)
        XCTAssertEqual(view.showsReorderControl, true)
        
        view.indentationLevel = 2
        TableViewCellStyle.indentationLevel(3).sideEffect(on: view)
        XCTAssertEqual(view.indentationLevel, 3)
        
        view.indentationWidth = 2
        TableViewCellStyle.indentationWidth(3).sideEffect(on: view)
        XCTAssertEqual(view.indentationWidth, 3)
        
        view.shouldIndentWhileEditing = false
        TableViewCellStyle.shouldIndentWhileEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.shouldIndentWhileEditing, true)
        
        view.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        TableViewCellStyle.separatorInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.separatorInset, .zero)
        
        view.focusStyle = .custom
        TableViewCellStyle.focusStyle(.default).sideEffect(on: view)
        XCTAssertEqual(view.focusStyle, .default)
        
        view.showsReorderControl = false
        Component<UITableViewCell>().tableViewCell(.showsReorderControl(true)).configure(item: view)
        XCTAssertEqual(view.showsReorderControl, true)
    }
    
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
        XCTAssertEqual(view.separatorInset, .zero)
        
        view.focusStyle = .custom
        AnyStyle<UITableViewCell>.focusStyle(.default).sideEffect(on: view)
        XCTAssertEqual(view.focusStyle, .default)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
