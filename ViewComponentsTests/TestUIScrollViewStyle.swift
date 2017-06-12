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
    
    static let allStyles: [UIScrollViewStyle<UIScrollView>] = [
        .contentOffset(.zero), .contentSize(.zero), .contentInset(.zero), .isScrollEnabled(true),
        .isDirectionalLockEnabled(true), .isPagingEnabled(true), .bounces(true), .alwaysBounceVertical(true),
        .alwaysBounceHorizontal(true), .canCancelContentTouches(true), .delaysContentTouches(true),
        .indicatorStyle(.black), .scrollIndicatorInsets(.zero), .showsHorizontalScrollIndicator(true),
        .showsVerticalScrollIndicator(true), .maximumZoomScale(0.4), .minimumZoomScale(0.4), .bouncesZoom(true)
    ]
    
    static var previousHashes: [Int : Any] { return TestUIImageViewStyle.accumulatedHashes }
    
    func testStyleEquatable() {
        XCTAssertEqual(UIScrollViewStyle.contentOffset(.zero), .contentOffset(.zero))
        XCTAssertEqual(UIScrollViewStyle.contentSize(.zero), .contentSize(.zero))
        XCTAssertEqual(UIScrollViewStyle.contentInset(.zero), .contentInset(.zero))
        XCTAssertEqual(UIScrollViewStyle.isScrollEnabled(true), .isScrollEnabled(true))
        XCTAssertEqual(UIScrollViewStyle.isDirectionalLockEnabled(true), .isDirectionalLockEnabled(true))
        XCTAssertEqual(UIScrollViewStyle.isPagingEnabled(true), .isPagingEnabled(true))
        XCTAssertEqual(UIScrollViewStyle.bounces(true), .bounces(true))
        XCTAssertEqual(UIScrollViewStyle.alwaysBounceVertical(true), .alwaysBounceVertical(true))
        XCTAssertEqual(UIScrollViewStyle.alwaysBounceHorizontal(true), .alwaysBounceHorizontal(true))
        XCTAssertEqual(UIScrollViewStyle.canCancelContentTouches(true), .canCancelContentTouches(true))
        XCTAssertEqual(UIScrollViewStyle.delaysContentTouches(true), .delaysContentTouches(true))
        XCTAssertEqual(UIScrollViewStyle.indicatorStyle(.black), .indicatorStyle(.black))
        XCTAssertEqual(UIScrollViewStyle.scrollIndicatorInsets(.zero), .scrollIndicatorInsets(.zero))
        XCTAssertEqual(UIScrollViewStyle.showsHorizontalScrollIndicator(true), .showsHorizontalScrollIndicator(true))
        XCTAssertEqual(UIScrollViewStyle.showsVerticalScrollIndicator(true), .showsVerticalScrollIndicator(true))
        XCTAssertEqual(UIScrollViewStyle.maximumZoomScale(0.4), .maximumZoomScale(0.4))
        XCTAssertEqual(UIScrollViewStyle.minimumZoomScale(0.4), .minimumZoomScale(0.4))
        XCTAssertEqual(UIScrollViewStyle.bouncesZoom(true), .bouncesZoom(true))
        XCTAssertNotEqual(UIScrollViewStyle.bouncesZoom(true), .minimumZoomScale(0.4))
    }
    
    func testStyleSideEffects() {
        let view = UIScrollView()
        
        view.contentOffset = CGPoint(x: 20, y: 20)
        UIScrollViewStyle.contentOffset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentOffset, .zero)
        
        view.contentSize = CGSize(width: 20, height: 20)
        UIScrollViewStyle.contentSize(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentSize, .zero)
        
        view.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        UIScrollViewStyle.contentInset(.zero).sideEffect(on: view)
        XCTAssertEqual(view.contentInset, .zero)
        
        view.isScrollEnabled = false
        UIScrollViewStyle.isScrollEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isScrollEnabled, true)
        
        view.isDirectionalLockEnabled = false
        UIScrollViewStyle.isDirectionalLockEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isDirectionalLockEnabled, true)
        
        view.isPagingEnabled = false
        UIScrollViewStyle.isPagingEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isPagingEnabled, true)
        
        view.bounces = false
        UIScrollViewStyle.bounces(true).sideEffect(on: view)
        XCTAssertEqual(view.bounces, true)
        
        view.alwaysBounceVertical = false
        UIScrollViewStyle.alwaysBounceVertical(true).sideEffect(on: view)
        XCTAssertEqual(view.alwaysBounceVertical, true)
        
        view.alwaysBounceHorizontal = false
        UIScrollViewStyle.alwaysBounceHorizontal(true).sideEffect(on: view)
        XCTAssertEqual(view.alwaysBounceHorizontal, true)
        
        view.canCancelContentTouches = false
        UIScrollViewStyle.canCancelContentTouches(true).sideEffect(on: view)
        XCTAssertEqual(view.canCancelContentTouches, true)
        
        view.delaysContentTouches = false
        UIScrollViewStyle.delaysContentTouches(true).sideEffect(on: view)
        XCTAssertEqual(view.delaysContentTouches, true)
        
        view.indicatorStyle = .black
        UIScrollViewStyle.indicatorStyle(.white).sideEffect(on: view)
        XCTAssertEqual(view.indicatorStyle, .white)
        
        view.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        UIScrollViewStyle.scrollIndicatorInsets(.zero).sideEffect(on: view)
        XCTAssertEqual(view.scrollIndicatorInsets, .zero)
        
        view.showsHorizontalScrollIndicator = false
        UIScrollViewStyle.showsHorizontalScrollIndicator(true).sideEffect(on: view)
        XCTAssertEqual(view.showsHorizontalScrollIndicator, true)
        
        view.showsVerticalScrollIndicator = false
        UIScrollViewStyle.showsVerticalScrollIndicator(true).sideEffect(on: view)
        XCTAssertEqual(view.showsVerticalScrollIndicator, true)
        
        view.maximumZoomScale = 0.2
        UIScrollViewStyle.maximumZoomScale(0.4).sideEffect(on: view)
        XCTAssertEqual(view.maximumZoomScale, 0.4)
        
        view.minimumZoomScale = 0.2
        UIScrollViewStyle.minimumZoomScale(0.4).sideEffect(on: view)
        XCTAssertEqual(view.minimumZoomScale, 0.4)
        
        view.bouncesZoom = false
        UIScrollViewStyle.bouncesZoom(true).sideEffect(on: view)
        XCTAssertEqual(view.bouncesZoom, true)
        
        view.bouncesZoom = false
        Component<UIScrollView>().scrollView(.bouncesZoom(true)).configure(item: view)
        XCTAssertEqual(view.bouncesZoom, true)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
