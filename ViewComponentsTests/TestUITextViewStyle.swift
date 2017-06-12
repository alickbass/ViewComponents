//
//  TestUITextViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 14/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUITextViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [UITextViewStyle<UITextView>] = [
        .text("test"), .attributedText(.init(string: "test")), .font(.systemFont(ofSize: 8)),
        .textColor(.red), .textAlignment(.center), .isEditable(true), .font(nil), .textColor(nil),
        .allowsEditingTextAttributes(true), .dataDetectorTypes(.address), .textContainerInset(.zero),
        .selectedRange(.init(location: 0, length: 0)), .clearsOnInsertion(true), .isSelectable(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUITextFieldStyle.accumulatedHashes }
    
    func testStyleEquatable() {
        XCTAssertEqual(UITextViewStyle.text("test"), .text("test"))
        XCTAssertEqual(UITextViewStyle.attributedText(.init(string: "test")), .attributedText(.init(string: "test")))
        XCTAssertEqual(UITextViewStyle.font(.systemFont(ofSize: 8)), .font(.systemFont(ofSize: 8)))
        XCTAssertEqual(UITextViewStyle.textColor(.red), .textColor(.red))
        XCTAssertEqual(UITextViewStyle.isEditable(true), .isEditable(true))
        XCTAssertEqual(UITextViewStyle.allowsEditingTextAttributes(true), .allowsEditingTextAttributes(true))
        XCTAssertEqual(UITextViewStyle.dataDetectorTypes(.address), .dataDetectorTypes(.address))
        XCTAssertEqual(UITextViewStyle.textAlignment(.center), .textAlignment(.center))
        XCTAssertEqual(UITextViewStyle.textContainerInset(.zero), .textContainerInset(.zero))
        XCTAssertEqual(UITextViewStyle.selectedRange(.init(location: 0, length: 0)), .selectedRange(.init(location: 0, length: 0)))
        XCTAssertEqual(UITextViewStyle.clearsOnInsertion(true), .clearsOnInsertion(true))
        XCTAssertEqual(UITextViewStyle.isSelectable(true), .isSelectable(true))
        XCTAssertNotEqual(UITextViewStyle.isSelectable(true), .clearsOnInsertion(true))
    }
    
    func testStyleSideEffects() {
        let view = UITextView()
        
        view.text = nil
        UITextViewStyle.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = nil
        UITextViewStyle.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertNotNil(view.attributedText)
        
        view.font = .boldSystemFont(ofSize: 12)
        UITextViewStyle.font(.systemFont(ofSize: 8)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 8))
        
        view.textColor = .blue
        UITextViewStyle.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .left
        UITextViewStyle.textAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .center)
        
        view.isEditable = false
        UITextViewStyle.isEditable(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditable, true)
        
        view.allowsEditingTextAttributes = false
        UITextViewStyle.allowsEditingTextAttributes(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsEditingTextAttributes, true)
        
        view.dataDetectorTypes = .all
        UITextViewStyle.dataDetectorTypes(.address).sideEffect(on: view)
        XCTAssertEqual(view.dataDetectorTypes, .address)
        
        view.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        UITextViewStyle.textContainerInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.textContainerInset, .zero)
        
        view.selectedRange = .init(location: 10, length: 10)
        UITextViewStyle.selectedRange(.init(location: 0, length: 0)).sideEffect(on: view)
        XCTAssertEqual(view.selectedRange, .init(location: 0, length: 0))
        
        view.clearsOnInsertion = false
        UITextViewStyle.clearsOnInsertion(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnInsertion, true)
        
        view.isSelectable = false
        UITextViewStyle.isSelectable(true).sideEffect(on: view)
        XCTAssertEqual(view.isSelectable, true)
        
        view.isSelectable = false
        Component<UITextView>().textView(.isSelectable(true)).configure(item: view)
        XCTAssertEqual(view.isSelectable, true)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
