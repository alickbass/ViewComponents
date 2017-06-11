//
//  TestUITextFieldStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 13/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUITextFieldStyle: XCTestCase {
    
    static let allStyles: [UITextFieldStyle<UITextField>] = [
        .text(nil), .text("test"), .attributedText(nil), .attributedText(.init(string: "test")),
        .placeholder(nil), .placeholder("test"), .attributedPlaceholder(nil), .attributedPlaceholder(.init(string: "test")),
        .font(.systemFont(ofSize: 8)), .textColor(.red), .textAlignment(.center), .adjustsFontSizeToFitWidth(true),
        .minimumFontSize(12), .clearsOnBeginEditing(true), .clearsOnInsertion(true), .allowsEditingTextAttributes(true),
        .borderStyle(.bezel), .background(nil), .background(UIImage()), .disabledBackground(nil),
        .disabledBackground(UIImage()), .clearButtonMode(.always), .leftViewMode(.always), .rightViewMode(.always)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUICollectionViewStyle.accumulatedHashes + TestUITextFieldStyle.allStyles.map({ $0.hashValue })
    }
    
    let image = UIImage()
    
    func testStyleEquatable() {
        XCTAssertEqual(UITextFieldStyle.text("test"), .text("test"))
        XCTAssertEqual(UITextFieldStyle.attributedText(.init(string: "test")), .attributedText(.init(string: "test")))
        XCTAssertEqual(UITextFieldStyle.placeholder("test"), .placeholder("test"))
        XCTAssertEqual(UITextFieldStyle.attributedPlaceholder(.init(string: "test")), .attributedPlaceholder(.init(string: "test")))
        XCTAssertEqual(UITextFieldStyle.font(.systemFont(ofSize: 8)), .font(.systemFont(ofSize: 8)))
        XCTAssertEqual(UITextFieldStyle.textColor(.red), .textColor(.red))
        XCTAssertEqual(UITextFieldStyle.textAlignment(.center), .textAlignment(.center))
        XCTAssertEqual(UITextFieldStyle.adjustsFontSizeToFitWidth(true), .adjustsFontSizeToFitWidth(true))
        XCTAssertEqual(UITextFieldStyle.minimumFontSize(12), .minimumFontSize(12))
        XCTAssertEqual(UITextFieldStyle.clearsOnBeginEditing(true), .clearsOnBeginEditing(true))
        XCTAssertEqual(UITextFieldStyle.clearsOnInsertion(true), .clearsOnInsertion(true))
        XCTAssertEqual(UITextFieldStyle.allowsEditingTextAttributes(true), .allowsEditingTextAttributes(true))
        XCTAssertEqual(UITextFieldStyle.borderStyle(.bezel), .borderStyle(.bezel))
        XCTAssertEqual(UITextFieldStyle.background(image), .background(image))
        XCTAssertEqual(UITextFieldStyle.disabledBackground(image), .disabledBackground(image))
        XCTAssertEqual(UITextFieldStyle.clearButtonMode(.always), .clearButtonMode(.always))
        XCTAssertEqual(UITextFieldStyle.leftViewMode(.always), .leftViewMode(.always))
        XCTAssertEqual(UITextFieldStyle.rightViewMode(.always), .rightViewMode(.always))
        XCTAssertNotEqual(UITextFieldStyle.rightViewMode(.always), .leftViewMode(.always))
    }
    
    func testStyleSideEffects() {
        let view = UITextField()
        
        view.text = nil
        UITextFieldStyle.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = nil
        UITextFieldStyle.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertNotNil(view.attributedText)
        
        view.placeholder = nil
        UITextFieldStyle.placeholder("test").sideEffect(on: view)
        XCTAssertEqual(view.placeholder, "test")
        
        view.attributedPlaceholder = nil
        UITextFieldStyle.attributedPlaceholder(.init(string: "test")).sideEffect(on: view)
        XCTAssertEqual(view.attributedPlaceholder, .init(string: "test"))
        
        view.font = .boldSystemFont(ofSize: 12)
        UITextFieldStyle.font(.systemFont(ofSize: 8)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 8))
        
        view.textColor = .blue
        UITextFieldStyle.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .left
        UITextFieldStyle.textAlignment(.center).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .center)
        
        view.adjustsFontSizeToFitWidth = false
        UITextFieldStyle.adjustsFontSizeToFitWidth(true).sideEffect(on: view)
        XCTAssertEqual(view.adjustsFontSizeToFitWidth, true)
        
        view.minimumFontSize = 10
        UITextFieldStyle.minimumFontSize(12).sideEffect(on: view)
        XCTAssertEqual(view.minimumFontSize, 12)
        
        view.clearsOnBeginEditing = false
        UITextFieldStyle.clearsOnBeginEditing(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnBeginEditing, true)
        
        view.clearsOnInsertion = false
        UITextFieldStyle.clearsOnInsertion(true).sideEffect(on: view)
        XCTAssertEqual(view.clearsOnInsertion, true)
        
        view.allowsEditingTextAttributes = false
        UITextFieldStyle.allowsEditingTextAttributes(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsEditingTextAttributes, true)
        
        view.borderStyle = .line
        UITextFieldStyle.borderStyle(.bezel).sideEffect(on: view)
        XCTAssertEqual(view.borderStyle, .bezel)
        
        view.background = nil
        UITextFieldStyle.background(image).sideEffect(on: view)
        XCTAssertEqual(view.background, image)
        
        view.disabledBackground = nil
        UITextFieldStyle.disabledBackground(image).sideEffect(on: view)
        XCTAssertEqual(view.disabledBackground, image)
        
        view.clearButtonMode = .never
        UITextFieldStyle.clearButtonMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.clearButtonMode, .always)
        
        view.leftViewMode = .never
        UITextFieldStyle.leftViewMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.leftViewMode, .always)
        
        view.rightViewMode = .never
        UITextFieldStyle.rightViewMode(.always).sideEffect(on: view)
        XCTAssertEqual(view.rightViewMode, .always)
        
        view.rightViewMode = .never
        Component<UITextField>().textField(.rightViewMode(.always)).configure(item: view)
        XCTAssertEqual(view.rightViewMode, .always)
    }
    
    func testHashValue() {
        var hashes = Set(TestUICollectionViewStyle.accumulatedHashes)
        
        for item in TestUITextFieldStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
