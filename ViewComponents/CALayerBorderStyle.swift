//
//  CALayerBorderStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 09/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

struct LayerBorder: StyleType {
    let cornerRadius: CGFloat
    let width: CGFloat
    let color: UIColor?
    
    func sideEffect(on layer: CALayer) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = width
        layer.borderColor = color?.cgColor
    }
    
    static func == (lhs: LayerBorder, rhs: LayerBorder) -> Bool {
        return lhs.cornerRadius == rhs.cornerRadius && lhs.width == rhs.width && lhs.color == rhs.color
    }
    
    var hashValue: Int {
        var hash = 5381
        hash = ((hash << 5) &+ hash) &+ cornerRadius.hashValue
        hash = ((hash << 5) &+ hash) &+ width.hashValue
        hash = ((hash << 5) &+ hash) &+ (color?.hashValue ?? 0)
        return hash
    }
}

public extension AnyStyle where T: CALayer {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    public static func border(cornerRadius: CGFloat = 0, width: CGFloat = 0, color: UIColor? = .black) -> AnyStyle<T> {
        let value = LayerBorder(cornerRadius: cornerRadius, width: width, color: color)
        return ViewStyle(value, key: .border, sideEffect: { $1.sideEffect(on: $0) }).toAnyStyle
    }
}

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    public static func border(cornerRadius: CGFloat = 0, width: CGFloat = 0, color: UIColor? = .black) -> AnyStyle<T> {
        let value = LayerBorder(cornerRadius: cornerRadius, width: width, color: color)
        return ViewStyle(value, key: .border, sideEffect: { $1.sideEffect(on: $0.layer) }).toAnyStyle
    }
}
