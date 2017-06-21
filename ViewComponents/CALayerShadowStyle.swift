//
//  CALayerShadowStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

struct LayerShadow: StyleType, CustomStringConvertible {
    let opacity: Float
    let radius: CGFloat
    let offset: CGSize
    let color: UIColor?
    let path: CGPath?
    
    func sideEffect(on layer: CALayer) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color?.cgColor
        layer.shadowPath = path
    }
    
    static func == (lhs: LayerShadow, rhs: LayerShadow) -> Bool {
        return lhs.opacity == rhs.opacity
            && lhs.radius == rhs.radius
            && lhs.offset == rhs.offset
            && lhs.color == rhs.color
            && lhs.path == rhs.path
    }
    
    var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ opacity.hashValue
        hash = ((hash << 5) &+ hash) &+ radius.hashValue
        hash = ((hash << 5) &+ hash) &+ offset.hashValue
        hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
        hash = ((hash << 5) &+ hash) &+ (path.map({ UIBezierPath(cgPath: $0) })?.hashValue ?? 0)
        return hash
    }
    
    var description: String {
        return "{\n\topacity: \(opacity),\n\tradius: \(radius),\n\toffset: \(offset),\n\tcolor: \(color._description),\n\tpath: \(path._description)\n}"
    }
}

public extension AnyStyle where T: CALayer {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = .black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return ViewStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0) }).toAnyStyle
    }
}

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = .black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return ViewStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0.layer) }).toAnyStyle
    }
}
