//
//  TestUILabelStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUILabelStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UILabel>] = [
        AnyStyle<UILabel>.text("test"), AnyStyle<UILabel>.text(nil), AnyStyle<UILabel>.attributedText(.init(string: "test")),
        AnyStyle<UILabel>.attributedText(nil), AnyStyle<UILabel>.font(.systemFont(ofSize: 12)), AnyStyle<UILabel>.textColor(.red),
        AnyStyle<UILabel>.textAlignment(.center), AnyStyle<UILabel>.lineBreakMode(.byClipping), AnyStyle<UILabel>.isEnabled(true),
        AnyStyle<UILabel>.adjustsFontSizeToFitWidth(true), AnyStyle<UILabel>.allowsDefaultTighteningForTruncation(true),
        AnyStyle<UILabel>.baselineAdjustment(.alignBaselines), .minimumScaleFactor(12), AnyStyle<UILabel>.numberOfLines(0),
        .highlightedTextColor(.red), .highlightedTextColor(nil), .isHighlighted(true), .shadowColor(.red),
        .shadowColor(nil), .shadowOffset(.zero)
    ]
    
    static var previousHashes: [Int : Any] { return TestUIViewStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UILabel()
        
        view.text = "someOtherString"
        AnyStyle<UILabel>.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = .init(string: "someOtherString")
        AnyStyle<UILabel>.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertEqual(view.attributedText, NSAttributedString(string: "test"))
        
        view.font = .systemFont(ofSize: 13)
        AnyStyle<UILabel>.font(.systemFont(ofSize: 12)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 12))
        
        view.textColor = .green
        AnyStyle<UILabel>.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .center
        AnyStyle<UILabel>.textAlignment(.justified).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .justified)
        
        view.lineBreakMode = .byClipping
        AnyStyle<UILabel>.lineBreakMode(.byTruncatingHead).sideEffect(on: view)
        XCTAssertEqual(view.lineBreakMode, .byTruncatingHead)
        
        view.isEnabled = true
        AnyStyle<UILabel>.isEnabled(false).sideEffect(on: view)
        XCTAssertEqual(view.isEnabled, false)
        
        view.adjustsFontSizeToFitWidth = true
        AnyStyle<UILabel>.adjustsFontSizeToFitWidth(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsFontSizeToFitWidth, false)
        
        view.allowsDefaultTighteningForTruncation = true
        AnyStyle<UILabel>.allowsDefaultTighteningForTruncation(false).sideEffect(on: view)
        XCTAssertEqual(view.allowsDefaultTighteningForTruncation, false)
        
        view.baselineAdjustment = .alignBaselines
        AnyStyle<UILabel>.baselineAdjustment(.alignCenters).sideEffect(on: view)
        XCTAssertEqual(view.baselineAdjustment, .alignCenters)
        
        view.minimumScaleFactor = 0.5
        AnyStyle<UILabel>.minimumScaleFactor(0.7).sideEffect(on: view)
        XCTAssertEqual(view.minimumScaleFactor, 0.7, accuracy: 0.001)
        
        view.numberOfLines = 12
        AnyStyle<UILabel>.numberOfLines(0).sideEffect(on: view)
        XCTAssertEqual(view.numberOfLines, 0)
        
        view.highlightedTextColor = .green
        AnyStyle<UILabel>.highlightedTextColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.highlightedTextColor, .red)
        
        view.isHighlighted = true
        AnyStyle<UILabel>.isHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, false)
        
        view.shadowColor = .green
        AnyStyle<UILabel>.shadowColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.shadowColor, .red)
        
        view.shadowOffset = CGSize(width: 20, height: 20)
        AnyStyle<UILabel>.shadowOffset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.shadowOffset, .zero)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
