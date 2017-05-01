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
    
}
