//
//  TestUITextFieldStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUITextFieldStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UITextField>] = [
        .text(nil), .text("test"), .attributedText(nil), .attributedText(.init(string: "test")),
        .placeholder(nil), .placeholder("test"), .attributedPlaceholder(nil), .attributedPlaceholder(.init(string: "test")),
        .font(.systemFont(ofSize: 8)), .textColor(.red), .textAlignment(.center), .adjustsFontSizeToFitWidth(true),
        .minimumFontSize(12), .clearsOnBeginEditing(true), .clearsOnInsertion(true), .allowsEditingTextAttributes(true),
        .borderStyle(.bezel), .background(nil), .background(UIImage()), .disabledBackground(nil),
        .disabledBackground(UIImage()), .clearButtonMode(.always), .leftViewMode(.always), .rightViewMode(.always)
    ]
    
    static var previousHashes: [Int : Any] { return TestUICollectionViewStyle.accumulatedHashes }
    
    let image = UIImage()
    
    func testAnyStyleSideEffects() {
        let view = UITextField()
        
        view.text = nil
        AnyStyle<UITextField>.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = nil
        AnyStyle<UITextField>.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertNotNil(view.attributedText)
        
        view.placeholder = nil
        AnyStyle<UITextField>.placeholder("test").sideEffect(on: view)
        XCTAssertEqual(view.placeholder, "test")
        
        view.attributedPlaceholder = nil
        AnyStyle<UITextField>.attributedPlaceholder(.init(string: "test")).sideEffect(on: view)
        XCTAssertEqual(view.attributedPlaceholder, .init(string: "test"))
        
        view.font = .boldSystemFont(ofSize: 12)
        AnyStyle<UITextField>.font(.systemFont(ofSize: 8)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 8))
        
        view.textColor = .blue
        AnyStyle<UITextField>.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .left
        AnyStyle<UITextField>.textAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .center)
        
        view.adjustsFontSizeToFitWidth = false
        AnyStyle<UITextField>.adjustsFontSizeToFitWidth(true).sideEffect(on: view)
        XCTAssertEqual(view.adjustsFontSizeToFitWidth, true)
        
        view.minimumFontSize = 10
        AnyStyle<UITextField>.minimumFontSize(12).sideEffect(on: view)
        XCTAssertEqual(view.minimumFontSize, 12)
        
        view.clearsOnBeginEditing = false
        AnyStyle<UITextField>.clearsOnBeginEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnBeginEditing, true)
        
        view.clearsOnInsertion = false
        AnyStyle<UITextField>.clearsOnInsertion(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnInsertion, true)
        
        view.allowsEditingTextAttributes = false
        AnyStyle<UITextField>.allowsEditingTextAttributes(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsEditingTextAttributes, true)
        
        view.borderStyle = .line
        AnyStyle<UITextField>.borderStyle(.bezel).sideEffect(on: view)
        XCTAssertEqual(view.borderStyle, .bezel)
        
        view.background = nil
        AnyStyle<UITextField>.background(image).sideEffect(on: view)
        XCTAssertEqual(view.background, image)
        
        view.disabledBackground = nil
        AnyStyle<UITextField>.disabledBackground(image).sideEffect(on: view)
        XCTAssertEqual(view.disabledBackground, image)
        
        view.clearButtonMode = .never
        AnyStyle<UITextField>.clearButtonMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.clearButtonMode, .always)
        
        view.leftViewMode = .never
        AnyStyle<UITextField>.leftViewMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.leftViewMode, .always)
        
        view.rightViewMode = .never
        AnyStyle<UITextField>.rightViewMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.rightViewMode, .always)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
