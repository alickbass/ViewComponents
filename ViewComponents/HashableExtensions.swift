//
//  HashableExtensions.swift
//  ViewComponents
//
//  Created by Oleksii on 11/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

extension CGPoint: Hashable {
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ x.hashValue
        hash = ((hash << 5) &+ hash) &+ y.hashValue
        return hash
    }
}

extension CGSize: Hashable {
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ width.hashValue
        hash = ((hash << 5) &+ hash) &+ height.hashValue
        return hash
    }
}

extension CGRect: Hashable {
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ origin.hashValue
        hash = ((hash << 5) &+ hash) &+ size.hashValue
        return hash
    }
}

extension UIEdgeInsets: Hashable {
    public var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ top.hashValue
        hash = ((hash << 5) &+ hash) &+ bottom.hashValue
        hash = ((hash << 5) &+ hash) &+ left.hashValue
        hash = ((hash << 5) &+ hash) &+ right.hashValue
        
        return hash
    }
}

extension NSRange: Hashable {
    public static func == (lhs: NSRange, rhs: NSRange) -> Bool {
        return lhs.length == rhs.length && lhs.location == rhs.location
    }
    
    public var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ length
        hash = ((hash << 5) &+ hash) &+ location
        return hash
    }
}

extension CAEdgeAntialiasingMask: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

extension UIDataDetectorTypes: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}
