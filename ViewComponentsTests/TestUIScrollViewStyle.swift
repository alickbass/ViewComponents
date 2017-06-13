//
//  TestUIScrollViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUIScrollViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UIScrollView>] = [
        .contentOffset(.zero), .contentSize(.zero), .contentInset(.zero), .isScrollEnabled(true),
        .isDirectionalLockEnabled(true), .isPagingEnabled(true), .bounces(true), .alwaysBounceVertical(true),
        .alwaysBounceHorizontal(true), .canCancelContentTouches(true), .delaysContentTouches(true),
        .indicatorStyle(.black), .scrollIndicatorInsets(.zero), .showsHorizontalScrollIndicator(true),
        .showsVerticalScrollIndicator(true), .maximumZoomScale(0.4), .minimumZoomScale(0.4), .bouncesZoom(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUIImageViewStyle.accumulatedHashes }
    
    func testAnyStyleSideEffects() {
        let view = UIScrollView()
        
        view.contentOffset = CGPoint(x: 20, y: 20)
        AnyStyle<UIScrollView>.contentOffset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentOffset, .zero)
        
        view.contentSize = CGSize(width: 20, height: 20)
        AnyStyle<UIScrollView>.contentSize(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentSize, .zero)
        
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        AnyStyle<UIScrollView>.contentInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentInset, .zero)
        
        view.isScrollEnabled = false
        AnyStyle<UIScrollView>.isScrollEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isScrollEnabled, true)
        
        view.isDirectionalLockEnabled = false
        AnyStyle<UIScrollView>.isDirectionalLockEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isDirectionalLockEnabled, true)
        
        view.isPagingEnabled = false
        AnyStyle<UIScrollView>.isPagingEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isPagingEnabled, true)
        
        view.bounces = false
        AnyStyle<UIScrollView>.bounces(true).sideEffect(on: view)
        XCTAssertEqual(view.bounces, true)
        
        view.alwaysBounceVertical = false
        AnyStyle<UIScrollView>.alwaysBounceVertical(true).sideEffect(on: view)
        XCTAssertEqual(view.alwaysBounceVertical, true)
        
        view.alwaysBounceHorizontal = false
        AnyStyle<UIScrollView>.alwaysBounceHorizontal(true).sideEffect(on: view)
        XCTAssertEqual(view.alwaysBounceHorizontal, true)
        
        view.canCancelContentTouches = false
        AnyStyle<UIScrollView>.canCancelContentTouches(true).sideEffect(on: view)
        XCTAssertEqual(view.canCancelContentTouches, true)
        
        view.delaysContentTouches = false
        AnyStyle<UIScrollView>.delaysContentTouches(true).sideEffect(on: view)
        XCTAssertEqual(view.delaysContentTouches, true)
        
        view.indicatorStyle = .black
        AnyStyle<UIScrollView>.indicatorStyle(.white).sideEffect(on: view)
        XCTAssertEqual(view.indicatorStyle, .white)
        
        view.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        AnyStyle<UIScrollView>.scrollIndicatorInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.scrollIndicatorInsets, .zero)
        
        view.showsHorizontalScrollIndicator = false
        AnyStyle<UIScrollView>.showsHorizontalScrollIndicator(true).sideEffect(on: view)
        XCTAssertEqual(view.showsHorizontalScrollIndicator, true)
        
        view.showsVerticalScrollIndicator = false
        AnyStyle<UIScrollView>.showsVerticalScrollIndicator(true).sideEffect(on: view)
        XCTAssertEqual(view.showsVerticalScrollIndicator, true)
        
        view.maximumZoomScale = 0.2
        AnyStyle<UIScrollView>.maximumZoomScale(0.4).sideEffect(on: view)
        XCTAssertEqual(view.maximumZoomScale, 0.4)
        
        view.minimumZoomScale = 0.2
        AnyStyle<UIScrollView>.minimumZoomScale(0.4).sideEffect(on: view)
        XCTAssertEqual(view.minimumZoomScale, 0.4)
        
        view.bouncesZoom = false
        AnyStyle<UIScrollView>.bouncesZoom(true).sideEffect(on: view)
        XCTAssertEqual(view.bouncesZoom, true)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
