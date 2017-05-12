//
//  TestTableViewCellStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestTableViewCellStyle: XCTestCase {
    
    static let allStyles: [TableViewCellStyle] = [
        TableViewCellStyle.accessoryType(.detailButton), TableViewCellStyle.editingAccessoryType(.detailButton),
        TableViewCellStyle.isSelected(true), TableViewCellStyle.selectionStyle(.gray), TableViewCellStyle.isHighlighted(true),
        TableViewCellStyle.isEditing(true), TableViewCellStyle.showsReorderControl(true),
        TableViewCellStyle.indentationLevel(3), TableViewCellStyle.indentationWidth(3), TableViewCellStyle.shouldIndentWhileEditing(true),
        TableViewCellStyle.separatorInset(.zero), TableViewCellStyle.focusStyle(.default)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestTableViewStyle.accumulatedHashes + TestTableViewCellStyle.allStyles.map({ $0.hashValue })
    }
    
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
        Component<UITableViewCell>().tableViewCellStyles(.showsReorderControl(true)).configure(view: view)
        XCTAssertEqual(view.showsReorderControl, true)
    }
    
    func testHashValue() {
        var hashes = Set(TestTableViewStyle.accumulatedHashes)
        
        for item in TestTableViewCellStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
