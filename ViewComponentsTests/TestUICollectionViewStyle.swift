//
//  TestUICollectionViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUICollectionViewStyle: XCTestCase, ViewTestType {
    
    static let allStyles: [AnyStyle<UICollectionView>] = [
        .isPrefetchingEnabled(true), .allowsSelection(true), .allowsMultipleSelection(true),
        .remembersLastFocusedIndexPath(true), .collectionViewLayout(UICollectionViewLayout())
    ]
    
    static var previousHashes: [Int : Any] { return TestTableViewCellStyle.accumulatedHashes }
    
    let layout = UICollectionViewLayout()
    
    func testAnyStyleSideEffects() {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        view.isPrefetchingEnabled = false
        AnyStyle<UICollectionView>.isPrefetchingEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isPrefetchingEnabled, true)
        
        view.allowsSelection = false
        AnyStyle<UICollectionView>.allowsSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelection, true)
        
        view.allowsMultipleSelection = false
        AnyStyle<UICollectionView>.allowsMultipleSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelection, true)
        
        view.remembersLastFocusedIndexPath = false
        AnyStyle<UICollectionView>.remembersLastFocusedIndexPath(true).sideEffect(on: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
        
        AnyStyle<UICollectionView>.collectionViewLayout(layout).sideEffect(on: view)
        XCTAssertEqual(view.collectionViewLayout, layout)
    }
    
    func testHashValue() {
        testAccumulatingHashes()
    }
}
