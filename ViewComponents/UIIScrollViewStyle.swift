//
//  UIIScrollViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 12/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UIScrollViewStyle: HashableConcreteStyle {
    case contentOffset(CGPoint)
    case contentSize(CGSize)
    case contentInset(UIEdgeInsets)
    case isScrollEnabled(Bool)
    case isDirectionalLockEnabled(Bool)
    case isPagingEnabled(Bool)
    case bounces(Bool)
    case alwaysBounceVertical(Bool)
    case alwaysBounceHorizontal(Bool)
    case canCancelContentTouches(Bool)
    case delaysContentTouches(Bool)
    case indicatorStyle(UIScrollViewIndicatorStyle)
    case scrollIndicatorInsets(UIEdgeInsets)
    case showsHorizontalScrollIndicator(Bool)
    case showsVerticalScrollIndicator(Bool)
    case maximumZoomScale(CGFloat)
    case minimumZoomScale(CGFloat)
    case bouncesZoom(Bool)

    public func sideEffect(on view: UIScrollView) {
        switch self {
        case let .contentOffset(value):
            view.contentOffset = value
        case let .contentSize(value):
            view.contentSize = value
        case let .contentInset(value):
            view.contentInset = value
        case let .isScrollEnabled(value):
            view.isScrollEnabled = value
        case let .isDirectionalLockEnabled(value):
            view.isDirectionalLockEnabled = value
        case let .isPagingEnabled(value):
            view.isPagingEnabled = value
        case let .bounces(value):
            view.bounces = value
        case let .alwaysBounceVertical(value):
            view.alwaysBounceVertical = value
        case let .alwaysBounceHorizontal(value):
            view.alwaysBounceHorizontal = value
        case let .canCancelContentTouches(value):
            view.canCancelContentTouches = value
        case let .delaysContentTouches(value):
            view.delaysContentTouches = value
        case let .indicatorStyle(value):
            view.indicatorStyle = value
        case let .scrollIndicatorInsets(value):
            view.scrollIndicatorInsets = value
        case let .showsHorizontalScrollIndicator(value):
            view.showsHorizontalScrollIndicator = value
        case let .showsVerticalScrollIndicator(value):
            view.showsVerticalScrollIndicator = value
        case let .maximumZoomScale(value):
            view.maximumZoomScale = value
        case let .minimumZoomScale(value):
            view.minimumZoomScale = value
        case let .bouncesZoom(value):
            view.bouncesZoom = value
        }
    }
    
    public static func == (lhs: UIScrollViewStyle, rhs: UIScrollViewStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.contentOffset(left), .contentOffset(right)):
            return left == right
        case let (.contentSize(left), .contentSize(right)):
            return left == right
        case let (.contentInset(left), .contentInset(right)),
             let (.scrollIndicatorInsets(left), .scrollIndicatorInsets(right)):
            return left == right
        case let (.isScrollEnabled(left), .isScrollEnabled(right)),
             let (.isDirectionalLockEnabled(left), .isDirectionalLockEnabled(right)),
             let (.isPagingEnabled(left), .isPagingEnabled(right)),
             let (.bounces(left), .bounces(right)),
             let (.alwaysBounceVertical(left), .alwaysBounceVertical(right)),
             let (.alwaysBounceHorizontal(left), .alwaysBounceHorizontal(right)),
             let (.canCancelContentTouches(left), .canCancelContentTouches(right)),
             let (.delaysContentTouches(left), .delaysContentTouches(right)),
             let (.showsHorizontalScrollIndicator(left), .showsHorizontalScrollIndicator(right)),
             let (.showsVerticalScrollIndicator(left), .showsVerticalScrollIndicator(right)),
             let (.bouncesZoom(left), .bouncesZoom(right)):
            return left == right
        case let (.maximumZoomScale(left), .maximumZoomScale(right)),
             let (.minimumZoomScale(left), .minimumZoomScale(right)):
            return left == right
        case let (.indicatorStyle(left), .indicatorStyle(right)):
            return left == right
        default:
            return false
        }
    }
    
    @inline(__always) static func startIndex() -> Int {
        return UIImageViewStyle.lastStyleIndex()
    }
    
    @inline(__always) static func stylesCount() -> Int {
        return 28
    }
    
    @inline(__always) func value() -> (index: Int, valueHash: Int) {
        switch self {
        case let .contentOffset(value):
            return (1, value.hashValue)
        case let .contentSize(value):
            return (2, value.hashValue)
        case let .contentInset(value):
            return (3, value.hashValue)
        case let .isScrollEnabled(value):
            return (4, value.hashValue)
        case let .isDirectionalLockEnabled(value):
            return (5, value.hashValue)
        case let .isPagingEnabled(value):
            return (6, value.hashValue)
        case let .bounces(value):
            return (7, value.hashValue)
        case let .alwaysBounceVertical(value):
            return (8, value.hashValue)
        case let .alwaysBounceHorizontal(value):
            return (9, value.hashValue)
        case let .canCancelContentTouches(value):
            return (10, value.hashValue)
        case let .delaysContentTouches(value):
            return (11, value.hashValue)
        case let .indicatorStyle(value):
            return (12, value.hashValue)
        case let .scrollIndicatorInsets(value):
            return (13, value.hashValue)
        case let .showsHorizontalScrollIndicator(value):
            return (14, value.hashValue)
        case let .showsVerticalScrollIndicator(value):
            return (15, value.hashValue)
        case let .maximumZoomScale(value):
            return (16, value.hashValue)
        case let .minimumZoomScale(value):
            return (17, value.hashValue)
        case let .bouncesZoom(value):
            return (28, value.hashValue)
        }
    }
}

public extension Component where T: UIScrollView {
    public func scrollView(_ styles: UIScrollViewStyle...) -> Component<T> {
        return adding(styles: styles)
    }
}
