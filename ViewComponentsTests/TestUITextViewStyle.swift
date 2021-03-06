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
    
    static let allStyles: [AnyStyle<UITextView>] = [
        .text("test"), .attributedText(.init(string: "test")), .font(.systemFont(ofSize: 8)),
        .textColor(.red), .textAlignment(.center), .isEditable(true),
        .allowsEditingTextAttributes(true), .dataDetectorTypes(.address), .textContainerInset(.zero),
        .selectedRange(.init(location: 0, length: 0)), .clearsOnInsertion(true), .isSelectable(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUITextFieldStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UITextView()
        
        view.text = nil
        AnyStyle<UITextView>.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = nil
        AnyStyle<UITextView>.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertNotNil(view.attributedText)
        
        view.font = .boldSystemFont(ofSize: 12)
        AnyStyle<UITextView>.font(.systemFont(ofSize: 8)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 8))
        
        view.textColor = .blue
        AnyStyle<UITextView>.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .left
        AnyStyle<UITextView>.textAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .center)
        
        view.isEditable = false
        AnyStyle<UITextView>.isEditable(true).sideEffect(on: view)
        XCTAssertEqual(view.isEditable, true)
        
        view.allowsEditingTextAttributes = false
        AnyStyle<UITextView>.allowsEditingTextAttributes(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsEditingTextAttributes, true)
        
        view.dataDetectorTypes = .all
        AnyStyle<UITextView>.dataDetectorTypes(.address).sideEffect(on: view)
        XCTAssertEqual(view.dataDetectorTypes, .address)
        
        view.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        AnyStyle<UITextView>.textContainerInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.textContainerInset, .zero)
        
        view.selectedRange = .init(location: 10, length: 10)
        AnyStyle<UITextView>.selectedRange(.init(location: 0, length: 0)).sideEffect(on: view)
        XCTAssertEqual(view.selectedRange, .init(location: 0, length: 0))
        
        view.clearsOnInsertion = false
        AnyStyle<UITextView>.clearsOnInsertion(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnInsertion, true)
        
        view.isSelectable = false
        AnyStyle<UITextView>.isSelectable(true).sideEffect(on: view)
        XCTAssertEqual(view.isSelectable, true)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
