//
//  TestUICollectionViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ViewComponents

class TestUICollectionViewStyle: XCTestCase {
    
    static let allStyles: [UICollectionViewStyle] = [
        .isPrefetchingEnabled(true), .allowsSelection(true), .allowsMultipleSelection(true),
        .remembersLastFocusedIndexPath(true), .collectionViewLayout(UICollectionViewLayout())
    ]
    
    static var accumulatedHashes: [Int] {
        return TestTableViewCellStyle.accumulatedHashes + TestUICollectionViewStyle.allStyles.map({ $0.hashValue })
    }
    
    let layout = UICollectionViewLayout()
    
    func testStyleEquatable() {
        XCTAssertEqual(UICollectionViewStyle.isPrefetchingEnabled(true), .isPrefetchingEnabled(true))
        XCTAssertEqual(UICollectionViewStyle.allowsSelection(true), .allowsSelection(true))
        XCTAssertEqual(UICollectionViewStyle.allowsMultipleSelection(true), .allowsMultipleSelection(true))
        XCTAssertEqual(UICollectionViewStyle.remembersLastFocusedIndexPath(true), .remembersLastFocusedIndexPath(true))
        XCTAssertEqual(UICollectionViewStyle.collectionViewLayout(layout), .collectionViewLayout(layout))
        XCTAssertNotEqual(UICollectionViewStyle.collectionViewLayout(layout), .remembersLastFocusedIndexPath(true))
    }
    
    func testStyleSideEffects() {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        view.isPrefetchingEnabled = false
        UICollectionViewStyle.isPrefetchingEnabled(true).sideEffect(on: view)
        XCTAssertEqual(view.isPrefetchingEnabled, true)
        
        view.allowsSelection = false
        UICollectionViewStyle.allowsSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsSelection, true)
        
        view.allowsMultipleSelection = false
        UICollectionViewStyle.allowsMultipleSelection(true).sideEffect(on: view)
        XCTAssertEqual(view.allowsMultipleSelection, true)
        
        view.remembersLastFocusedIndexPath = false
        UICollectionViewStyle.remembersLastFocusedIndexPath(true).sideEffect(on: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
        
        UICollectionViewStyle.collectionViewLayout(layout).sideEffect(on: view)
        XCTAssertEqual(view.collectionViewLayout, layout)
        
        view.remembersLastFocusedIndexPath = false
        Component<UICollectionView>().collectionViewStyles(.remembersLastFocusedIndexPath(true)).configure(view: view)
        XCTAssertEqual(view.remembersLastFocusedIndexPath, true)
    }
    
    func testHashValue() {
        var hashes = Set(TestTableViewCellStyle.accumulatedHashes)
        
        for item in TestUICollectionViewStyle.allStyles {
            let hash = item.hashValue
            XCTAssertFalse(hashes.contains(hash))
            hashes.insert(hash)
        }
    }
}
