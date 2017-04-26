//
//  ViewComponentsTests.swift
//  ViewComponentsTests
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import XCTest
@testable import ViewComponents

class ViewComponentsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        class SuperView: UIView {
            let customView = CustomView()
        }
        
        class CustomView: UIView {
            let button = UIButton()
        }
        
        let button = Component<UIButton>().buttonStyles(.title("Some", for: .normal))
        let custom = Component<CustomView>().viewStyles(.alpha(0.2)).child(button, { $0.button })
        let component = Component<SuperView>().child(custom, { $0.customView })
        
        
        let view = SuperView()
        
        component.configure(view: view)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
