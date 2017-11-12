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
    
    /**
     Shadow of the layer
     
     - parameter opacity: The opacity of the layer’s shadow. Animatable. The value in this property must be
     in the range 0.0 (transparent) to 1.0 (opaque). The default value of this property is 0.0.
     
     - parameter radius: The blur radius (in points) used to render the layer’s shadow. Animatable. The default
     value of this property is 3.0.
     
     - parameter offset: The offset (in points) of the layer’s shadow. Animatable.
     The default value of this property is (0.0, -3.0).
     
     - parameter color: The color of the layer’s shadow. Animatable.
     The default value of this property is an opaque black color.
     The value of this property is retained using the Core Foundation retain/release semantics. This behavior
     occurs despite the fact that the property declaration appears to use the default assign semantics for object retention.
     
     - parameter path: The shape of the layer’s shadow. Animatable.
     The default value of this property is nil, which causes the layer to use a standard shadow shape. If you specify a value for this property, the layer creates its shadow using the specified path instead of the layer’s composited alpha channel. The path you provide defines the outline of the shadow. It is filled using the non-zero winding rule and the current shadow color, opacity, and blur radius.
     Unlike most animatable properties, this property (as with all CGPathRef animatable properties) does not support implicit animation. However, the path object may be animated using any of the concrete subclasses of CAPropertyAnimation. Paths will interpolate as a linear blend of the "on-line" points; "off-line" points may be interpolated non-linearly (to preserve continuity of the curve's derivative). If the two paths have a different number of control points or segments, the results are undefined. If the path extends outside the layer bounds it will not automatically be clipped to the layer, only if the normal layer masking rules cause that.
     Specifying an explicit path usually improves rendering performance.
     The value of this property is retained using the Core Foundation retain/release semantics. This behavior occurs despite the fact that the property declaration appears to use the default assign semantics for object retention.
     */
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = .black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return ViewStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0) }).toAnyStyle
    }
}

public extension AnyStyle where T: UIView {
    private typealias LayerStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    /**
     Shadow of the view's layer
     
     - parameter opacity: The opacity of the layer’s shadow. Animatable. The value in this property must be
     in the range 0.0 (transparent) to 1.0 (opaque). The default value of this property is 0.0.
     
     - parameter radius: The blur radius (in points) used to render the layer’s shadow. Animatable. The default
     value of this property is 3.0.
     
     - parameter offset: The offset (in points) of the layer’s shadow. Animatable.
     The default value of this property is (0.0, -3.0).
     
     - parameter color: The color of the layer’s shadow. Animatable.
     The default value of this property is an opaque black color.
     The value of this property is retained using the Core Foundation retain/release semantics. This behavior
     occurs despite the fact that the property declaration appears to use the default assign semantics for object retention.
     
     - parameter path: The shape of the layer’s shadow. Animatable.
     The default value of this property is nil, which causes the layer to use a standard shadow shape. If you specify a value for this property, the layer creates its shadow using the specified path instead of the layer’s composited alpha channel. The path you provide defines the outline of the shadow. It is filled using the non-zero winding rule and the current shadow color, opacity, and blur radius.
     Unlike most animatable properties, this property (as with all CGPathRef animatable properties) does not support implicit animation. However, the path object may be animated using any of the concrete subclasses of CAPropertyAnimation. Paths will interpolate as a linear blend of the "on-line" points; "off-line" points may be interpolated non-linearly (to preserve continuity of the curve's derivative). If the two paths have a different number of control points or segments, the results are undefined. If the path extends outside the layer bounds it will not automatically be clipped to the layer, only if the normal layer masking rules cause that.
     Specifying an explicit path usually improves rendering performance.
     The value of this property is retained using the Core Foundation retain/release semantics. This behavior occurs despite the fact that the property declaration appears to use the default assign semantics for object retention.
     */
    public static func shadow(opacity: Float = 0.0, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0.0, height: -3.0), color: UIColor? = .black, path: CGPath? = nil) -> AnyStyle<T> {
        let value = LayerShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
        return LayerStyle(value, key: .shadow, sideEffect: { $1.sideEffect(on: $0.layer) }).toAnyStyle
    }
}
