//
//  TestUILabelStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 01/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUILabelStyle: XCTestCase {
    
    static let allStyles: [UILabelStyle<UILabel>] = [
        UILabelStyle.text("test"), UILabelStyle.text(nil), UILabelStyle.attributedText(.init(string: "test")),
        UILabelStyle.attributedText(nil), UILabelStyle.font(.systemFont(ofSize: 12)), UILabelStyle.textColor(.red),
        UILabelStyle.textAlignment(.center), UILabelStyle.lineBreakMode(.byClipping), UILabelStyle.isEnabled(true),
        UILabelStyle.adjustsFontSizeToFitWidth(true), UILabelStyle.allowsDefaultTighteningForTruncation(true),
        UILabelStyle.baselineAdjustment(.alignBaselines), .minimumScaleFactor(12), UILabelStyle.numberOfLines(0),
        .highlightedTextColor(.red), .highlightedTextColor(nil), .isHighlighted(true), .shadowColor(.red),
        .shadowColor(nil), .shadowOffset(.zero)
    ]
    
    static var accumulatedHashes: [Int] {
        return TestUIViewStyle.accumulatedHashes + TestUILabelStyle.allStyles.map({ $0.hashValue })
    }
    
    func testStyleEquatable() {
        XCTAssertEqual(UILabelStyle.text("test"), .text("test"))
        XCTAssertNotEqual(UILabelStyle.text("test"), .text("notTest"))
        XCTAssertEqual(UILabelStyle.attributedText(.init(string: "test")), .attributedText(.init(string: "test")))
        XCTAssertNotEqual(UILabelStyle.attributedText(.init(string: "test")), .attributedText(.init(string: "notTest")))
        XCTAssertEqual(UILabelStyle.font(.systemFont(ofSize: 12)), .font(.systemFont(ofSize: 12)))
        XCTAssertNotEqual(UILabelStyle.font(.systemFont(ofSize: 12)), .font(.systemFont(ofSize: 13)))
        XCTAssertEqual(UILabelStyle.textColor(.red), .textColor(.red))
        XCTAssertNotEqual(UILabelStyle.textColor(.red), .textColor(.green))
        XCTAssertEqual(UILabelStyle.textAlignment(.center), .textAlignment(.center))
        XCTAssertNotEqual(UILabelStyle.textAlignment(.center), .textAlignment(.justified))
        XCTAssertEqual(UILabelStyle.lineBreakMode(.byClipping), .lineBreakMode(.byClipping))
        XCTAssertNotEqual(UILabelStyle.lineBreakMode(.byClipping), .lineBreakMode(.byCharWrapping))
        XCTAssertEqual(UILabelStyle.isEnabled(true), .isEnabled(true))
        XCTAssertNotEqual(UILabelStyle.isEnabled(true), .isEnabled(false))
        XCTAssertEqual(UILabelStyle.adjustsFontSizeToFitWidth(true), .adjustsFontSizeToFitWidth(true))
        XCTAssertNotEqual(UILabelStyle.adjustsFontSizeToFitWidth(true), .adjustsFontSizeToFitWidth(false))
        XCTAssertEqual(UILabelStyle.allowsDefaultTighteningForTruncation(true), .allowsDefaultTighteningForTruncation(true))
        XCTAssertNotEqual(UILabelStyle.allowsDefaultTighteningForTruncation(true), .allowsDefaultTighteningForTruncation(false))
        XCTAssertEqual(UILabelStyle.baselineAdjustment(.alignBaselines), .baselineAdjustment(.alignBaselines))
        XCTAssertNotEqual(UILabelStyle.baselineAdjustment(.alignBaselines), .baselineAdjustment(.alignCenters))
        XCTAssertEqual(UILabelStyle.minimumScaleFactor(12), .minimumScaleFactor(12))
        XCTAssertNotEqual(UILabelStyle.minimumScaleFactor(12), .minimumScaleFactor(13))
        XCTAssertEqual(UILabelStyle.numberOfLines(0), .numberOfLines(0))
        XCTAssertNotEqual(UILabelStyle.numberOfLines(0), .numberOfLines(1))
        XCTAssertEqual(UILabelStyle.highlightedTextColor(.red), .highlightedTextColor(.red))
        XCTAssertNotEqual(UILabelStyle.highlightedTextColor(.red), .highlightedTextColor(.green))
        XCTAssertEqual(UILabelStyle.isHighlighted(true), .isHighlighted(true))
        XCTAssertNotEqual(UILabelStyle.isHighlighted(true), .isHighlighted(false))
        XCTAssertEqual(UILabelStyle.shadowColor(.red), .shadowColor(.red))
        XCTAssertNotEqual(UILabelStyle.shadowColor(.red), .shadowColor(.green))
        XCTAssertEqual(UILabelStyle.shadowOffset(.zero), .shadowOffset(.zero))
        XCTAssertNotEqual(UILabelStyle.shadowOffset(.zero), .shadowOffset(.init(width: 20, height: 20)))
        XCTAssertNotEqual(UILabelStyle.shadowOffset(.zero), .lineBreakMode(.byClipping))
    }
    
    func testStyleSideEffects() {
        let view = UILabel()
        
        view.text = "someOtherString"
        UILabelStyle.text("test").sideEffect(on: view)
        XCTAssertEqual(view.text, "test")
        
        view.attributedText = .init(string: "someOtherString")
        UILabelStyle.attributedText(.init(string: "test")).sideEffect(on: view)
        XCTAssertEqual(view.attributedText, NSAttributedString(string: "test"))
        
        view.font = .systemFont(ofSize: 13)
        UILabelStyle.font(.systemFont(ofSize: 12)).sideEffect(on: view)
        XCTAssertEqual(view.font, .systemFont(ofSize: 12))
        
        view.textColor = .green
        UILabelStyle.textColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.textColor, .red)
        
        view.textAlignment = .center
        UILabelStyle.textAlignment(.justified).sideEffect(on: view)
        XCTAssertEqual(view.textAlignment, .justified)
        
        view.lineBreakMode = .byClipping
        UILabelStyle.lineBreakMode(.byTruncatingHead).sideEffect(on: view)
        XCTAssertEqual(view.lineBreakMode, .byTruncatingHead)
        
        view.isEnabled = true
        UILabelStyle.isEnabled(false).sideEffect(on: view)
        XCTAssertEqual(view.isEnabled, false)
        
        view.adjustsFontSizeToFitWidth = true
        UILabelStyle.adjustsFontSizeToFitWidth(false).sideEffect(on: view)
        XCTAssertEqual(view.adjustsFontSizeToFitWidth, false)
        
        view.allowsDefaultTighteningForTruncation = true
        UILabelStyle.allowsDefaultTighteningForTruncation(false).sideEffect(on: view)
        XCTAssertEqual(view.allowsDefaultTighteningForTruncation, false)
        
        view.baselineAdjustment = .alignBaselines
        UILabelStyle.baselineAdjustment(.alignCenters).sideEffect(on: view)
        XCTAssertEqual(view.baselineAdjustment, .alignCenters)
        
        view.minimumScaleFactor = 0.5
        UILabelStyle.minimumScaleFactor(0.7).sideEffect(on: view)
        XCTAssertEqualWithAccuracy(view.minimumScaleFactor, 0.7, accuracy: 0.001)
        
        view.numberOfLines = 12
        UILabelStyle.numberOfLines(0).sideEffect(on: view)
        XCTAssertEqual(view.numberOfLines, 0)
        
        view.highlightedTextColor = .green
        UILabelStyle.highlightedTextColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.highlightedTextColor, .red)
        
        view.isHighlighted = true
        UILabelStyle.isHighlighted(false).sideEffect(on: view)
        XCTAssertEqual(view.isHighlighted, false)
        
        view.shadowColor = .green
        UILabelStyle.shadowColor(.red).sideEffect(on: view)
        XCTAssertEqual(view.shadowColor, .red)
        
        view.shadowOffset = CGSize(width: 20, height: 20)
        UILabelStyle.shadowOffset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.shadowOffset, .zero)
        
        view.isHighlighted = false
        Component<UILabel>().label(.isHighlighted(true)).configure(item: view)
        XCTAssertEqual(view.isHighlighted, true)
    }
    
    func testHashValue() {
        var hashes = Set(TestUIViewStyle.accumulatedHashes)
        
        for item in TestUILabelStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
