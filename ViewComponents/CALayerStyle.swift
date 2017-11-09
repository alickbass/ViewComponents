//
//  CALayerStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

/**
 An enum defining how the contents of the layer is mapped into its
 bounds rect. Note that CAGravity.bottom always means "Minimum Y" and
 CAGravity.top always means "Maximum Y". */
public enum CAGravity: RawRepresentable {
    ///The content is horizontally and vertically centered in the bounds rectangle.
    case center
    ///The content is horizontally centered at the top-edge of the bounds rectangle.
    case top
    ///The content is horizontally centered at the bottom-edge of the bounds rectangle.
    case bottom
    ///The content is vertically centered at the left-edge of the bounds rectangle.
    case left
    ///The content is vertically centered at the right-edge of the bounds rectangle.
    case right
    ///The content is positioned in the top-left corner of the bounds rectangle.
    case topLeft
    ///The content is positioned in the top-right corner of the bounds rectangle.
    case topRight
    ///The content is positioned in the bottom-left corner of the bounds rectangle.
    case bottomLeft
    ///The content is positioned in the bottom-right corner of the bounds rectangle.
    case bottomRight
    ///The content is resized to fit the entire bounds rectangle.
    case resize
    /**
     The content is resized to fit the bounds rectangle, preserving the aspect of
     the content. If the content does not completely fill the bounds rectangle,
     the content is centered in the partial axis.
     */
    case resizeAspect
    /**
     The content is resized to completely fill the bounds rectangle, while still
     preserving the aspect of the content. The content is centered in the axis it exceeds.
     */
    case resizeAspectFill
    
    public var rawValue: String {
        switch self {
        case .center: return kCAGravityCenter
        case .top: return kCAGravityTop
        case .bottom: return kCAGravityBottom
        case .left: return kCAGravityLeft
        case .right: return kCAGravityRight
        case .topLeft: return kCAGravityTopLeft
        case .topRight: return kCAGravityTopRight
        case .bottomLeft: return kCAGravityBottomLeft
        case .bottomRight: return kCAGravityBottomRight
        case .resize: return kCAGravityResize
        case .resizeAspect: return kCAGravityResizeAspect
        case .resizeAspectFill: return kCAGravityResizeAspectFill
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case kCAGravityCenter: self = .center
        case kCAGravityTop: self = .top
        case kCAGravityBottom: self = .bottom
        case kCAGravityLeft: self = .left
        case kCAGravityRight: self = .right
        case kCAGravityTopLeft: self = .topLeft
        case kCAGravityTopRight: self = .topRight
        case kCAGravityBottomLeft: self = .bottomLeft
        case kCAGravityBottomRight: self = .bottomRight
        case kCAGravityResize: self = .resize
        case kCAGravityResizeAspect: self = .resizeAspect
        case kCAGravityResizeAspectFill: self = .resizeAspectFill
        default: return nil
        }
    }
}

@available(iOS 10.0, *)
public enum CAContentsFormat: RawRepresentable {
    case RGBA8Uint, RGBA16Float, gray8Uint
    
    public var rawValue: String {
        switch self {
        case .RGBA8Uint: return kCAContentsFormatRGBA8Uint
        case .RGBA16Float: return kCAContentsFormatRGBA16Float
        case .gray8Uint: return kCAContentsFormatGray8Uint
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case kCAContentsFormatRGBA8Uint: self = .RGBA8Uint
        case kCAContentsFormatRGBA16Float: self = .RGBA16Float
        case kCAContentsFormatGray8Uint: self = .gray8Uint
        default: return nil
        }
    }
}

enum CALayerStyleKey: Int, StyleKey {
    case contentsGravity = 0, opacity, isHidden
    case masksToBounds, mask, isDoubleSided
    case backgroundColor, allowsEdgeAntialiasing, allowsGroupOpacity
    case isOpaque, edgeAntialiasingMask, isGeometryFlipped
    case drawsAsynchronously, shouldRasterize, rasterizationScale
    case contentsFormat, frame, bounds
    case position, zPosition, anchorPointZ
    case anchorPoint, contentsScale, name
    case shadow, border
}

public extension AnyStyle where T: CALayer {
    private typealias ViewStyle<Item> = Style<T, Item, CALayerStyleKey>
    
    /**
     Define how the contents of the layer is mapped into its bounds rect
     
     - parameter gravity: type of gravity from enum `CAGravity`
     */
    public static func contentsGravity(_ gravity: CAGravity) -> AnyStyle<T> {
        return ViewStyle(gravity, key: .contentsGravity, sideEffect: { $0.contentsGravity = $1.rawValue }).toAnyStyle
    }
    
    /**
     The opacity of the receiver. Animatable.
     
     The value of this property must be in the range 0.0 (transparent) to 1.0 (opaque).
     Values outside that range are clamped to the minimum or maximum.
     
     - parameter opacity: The opacity of the receiver.
     */
    public static func opacity(_ opacity: Float) -> AnyStyle<T> {
        return ViewStyle(opacity, key: .opacity, sideEffect: { $0.opacity = $1 }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether the layer is displayed. Animatable.
     The default value of this property is false.
     */
    public static func isHidden(_ isHidden: Bool) -> AnyStyle<T> {
        return ViewStyle(isHidden, key: .isHidden, sideEffect: { $0.isHidden = $1 }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether sublayers are clipped to the layer’s bounds. Animatable.
     
     When the value of this property is true, Core Animation creates an implicit clipping
     mask that matches the bounds of the layer and includes any corner radius effects. If
     a value for the mask property is also specified, the two masks are multiplied to get the final mask value.
     
     The default value of this property is false.
     */
    public static func masksToBounds(_ masksToBounds: Bool) -> AnyStyle<T> {
        return ViewStyle(masksToBounds, key: .masksToBounds, sideEffect: { $0.masksToBounds = $1 }).toAnyStyle
    }
    
    /**
     An optional layer whose alpha channel is used to mask the layer’s content.
     
     The layer’s alpha channel determines how much of the layer’s content and background shows
     through. Fully or partially opaque pixels allow the underlying content to show through but
     fully transparent pixels block that content.
     
     The default value of this property is nil nil. When configuring a mask, remember to set the
     size and position of the mask layer to ensure it is aligned properly with the layer it masks.
     */
    public static func mask(_ mask: CALayer?) -> AnyStyle<T> {
        return ViewStyle(mask, key: .mask, sideEffect: { $0.mask = $1 }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether the layer displays its content when facing away from the viewer. Animatable.
     
     When the value in this property is false, the layer hides its content when it faces away from the viewer.
     The default value of this property is true.
     */
    public static func isDoubleSided(_ isDoubleSided: Bool) -> AnyStyle<T> {
        return ViewStyle(isDoubleSided, key: .isDoubleSided, sideEffect: { $0.isDoubleSided = $1 }).toAnyStyle
    }
    
    /**
     The background color of the receiver. Animatable.
     
     The default value of this property is nil.
     */
    public static func backgroundColor(_ color: UIColor?) -> AnyStyle<T> {
        return ViewStyle(color, key: .backgroundColor, sideEffect: { $0.backgroundColor = $1?.cgColor }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether the layer is allowed to perform edge antialiasing.
     
     When the value is true, the layer is allowed to antialias its edges, as requested by the value in the
     layer’s edgeAntialiasingMask property. The default value is read from the boolean UIViewEdgeAntialiasing
     property in the main bundle’s Info.plist file. If no value is found, the default value is false.
     */
    public static func allowsEdgeAntialiasing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsEdgeAntialiasing, sideEffect: { $0.allowsEdgeAntialiasing = $1 }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether the layer is allowed to composite itself as a group separate from its parent.
     
     When the value is true and the layer’s opacity property value is less than 1.0, the layer is allowed to
     composite itself as a group separate from its parent. This gives correct results when the layer contains
     multiple opaque components, but may reduce performance.
     
     The default value is read from the boolean UIViewGroupOpacity property in the main bundle’s Info.plist
     file. If no value is found, the default value is true for apps linked against the iOS 7 SDK or later and
     false for apps linked against an earlier SDK.
     */
    public static func allowsGroupOpacity(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .allowsGroupOpacity, sideEffect: { $0.allowsGroupOpacity = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value indicating whether the layer contains completely opaque content.
     
     The default value of this property is false. If your app draws completely opaque content that fills the
     layer’s bounds, setting this property to true lets the system optimize the rendering behavior for the
     layer. Specifically, when the layer creates the backing store for your drawing commands, Core Animation
     omits the alpha channel of that backing store. Doing so can improve the performance of compositing
     operations. If you set the value of this property to true, you must fill the layer’s bounds with opaque content.
     
     Setting this property affects only the backing store managed by Core Animation. If you assign an image
     with an alpha channel to the layer’s contents property, that image retains its alpha channel regardless
     of the value of this property.
     */
    public static func isOpaque(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isOpaque, sideEffect: { $0.isOpaque = $1 }).toAnyStyle
    }
    
    /**
     A bitmask defining how the edges of the receiver are rasterized.
     
     This property specifies which edges of the layer are antialiased and is a combination of the constants
     defined in CAEdgeAntialiasingMask. You can enable or disable antialiasing for each edge (top, left, bottom,
     right) separately. By default antialiasing is enabled for all edges.
     
     Typically, you would use this property to disable antialiasing for edges that abut edges of other layers,
     to eliminate the seams that would otherwise occur.
     */
    public static func edgeAntialiasingMask(_ mask: CAEdgeAntialiasingMask) -> AnyStyle<T> {
        return ViewStyle(mask, key: .edgeAntialiasingMask, sideEffect: { $0.edgeAntialiasingMask = $1 }).toAnyStyle
    }
    
    /**
     A Boolean that indicates whether the geometry of the layer and its sublayers is flipped vertically.
     
     If the layer is providing the backing for a layer-backed view, the view is responsible for managing the value
     in this property. For standalone layers, this property controls whether geometry values for the layer are
     interpreted using the standard or flipped coordinate system. The value of this property does not affect the
     rendering of the layer’s content.
     
     The default value of this property is false.
     */
    public static func isGeometryFlipped(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isGeometryFlipped, sideEffect: { $0.isGeometryFlipped = $1 }).toAnyStyle
    }
    
    /**
     A Boolean indicating whether drawing commands are deferred and processed asynchronously in a background thread.
     
     When this property is set to true, the graphics context used to draw the layer’s contents queues drawing
     commands and executes them on a background thread rather than executing them synchronously. Performing
     these commands asynchronously can improve performance in some apps. However, you should always measure
     the actual performance benefits before enabling this capability.
     
     The default value for this property is false.
     */
    public static func drawsAsynchronously(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .drawsAsynchronously, sideEffect: { $0.drawsAsynchronously = $1 }).toAnyStyle
    }
    
    /**
     A Boolean that indicates whether the layer is rendered as a bitmap before compositing. Animatable
     
     When the value of this property is true, the layer is rendered as a bitmap in its local coordinate
     space and then composited to the destination with any other content. Shadow effects and any filters
     in the filters property are rasterized and included in the bitmap. However, the current opacity of
     the layer is not rasterized. If the rasterized bitmap requires scaling during compositing, the filters
     in the minificationFilter and magnificationFilter properties are applied as needed.
     
     When the value of this property is false, the layer is composited directly into the destination whenever
     possible. The layer may still be rasterized prior to compositing if certain features of the compositing
     model (such as the inclusion of filters) require it.
     
     The default value of this property is false.
     */
    public static func shouldRasterize(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .shouldRasterize, sideEffect: { $0.shouldRasterize = $1 }).toAnyStyle
    }
    
    /**
     The scale at which to rasterize content, relative to the coordinate space of the layer. Animatable
     
     When the value in the shouldRasterize property is true, the layer uses this property to determine
     whether to scale the rasterized content (and by how much). The default value of this property is 1.0,
     which indicates that the layer should be rasterized at its current size. Larger values magnify the
     content and smaller values shrink it.
     */
    public static func rasterizationScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .rasterizationScale, sideEffect: { $0.rasterizationScale = $1 }).toAnyStyle
    }
    
    /**
     A hint for the desired storage format of the layer contents.
     
     The default value of this property is CAContentsFormat.RGBA8Uint.
     
     UIView and layer-backed NSView objects may change the value to a format appropriate for the current device.
     */
    @available(iOS 10.0, *)
    public static func contentsFormat(_ value: CAContentsFormat) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentsFormat, sideEffect: { $0.contentsFormat = $1.rawValue }).toAnyStyle
    }
    
    /**
     The layer’s frame rectangle.
     
     The frame rectangle is position and size of the layer specified in the superlayer’s coordinate space.
     For layers, the frame rectangle is a computed property that is derived from the values in thebounds,
     anchorPoint and position properties. When you assign a new value to this property, the layer changes its
     position and bounds properties to match the rectangle you specified. The values of each coordinate in the
     rectangle are measured in points.
     
     Do not set the frame if the transform property applies a rotation transform that is not a multiple of 90 degrees.
     
     For more information about the relationship between the frame, bounds, anchorPoint and position properties,
     see Core Animation Programming Guide.
     
     **Note**
     
     The frame property is not directly animatable. Instead you should animate the appropriate combination of the
     bounds, anchorPoint and position properties to achieve the desired result.
     */
    public static func frame(_ value: CGRect) -> AnyStyle<T> {
        return ViewStyle(value, key: .frame, sideEffect: { $0.frame = $1 }).toAnyStyle
    }
    
    /**
     The layer’s bounds rectangle. Animatable.
     
     The bounds rectangle is the origin and size of the layer in its own coordinate space. When you create a new
     standalone layer, the default value for this property is an empty rectangle, which you must change before
     using the layer. The values of each coordinate in the rectangle are measured in points.
     
     For more information about the relationship between the frame, bounds, anchorPoint and position properties,
     see Core Animation Programming Guide.
     */
    public static func bounds(_ value: CGRect) -> AnyStyle<T> {
        return ViewStyle(value, key: .bounds, sideEffect: { $0.bounds = $1 }).toAnyStyle
    }
    
    /**
     The layer’s position in its superlayer’s coordinate space. Animatable.
     
     The value of this property is specified in points and is always specified relative to the value in the
     anchorPoint property. For new standalone layers, the default position is set to (0.0, 0.0). Changing the
     frame property also updates the value in this property.
     
     For more information about the relationship between the frame, bounds, anchorPoint and position properties,
     see Core Animation Programming Guide.
     */
    public static func position(_ value: CGPoint) -> AnyStyle<T> {
        return ViewStyle(value, key: .position, sideEffect: { $0.position = $1 }).toAnyStyle
    }
    
    /**
     The layer’s position on the z axis. Animatable.
     
     The default value of this property is 0. Changing the value of this property changes the the front-to-back
     ordering of layers onscreen. Higher values place this layer visually closer to the viewer than layers with
     lower values. This can affect the visibility of layers whose frame rectangles overlap.
     
     The value of this property is measured in points. The range of this property is single-precision,
     floating-point -greatestFiniteMagnitude to greatestFiniteMagnitude.
     */
    public static func zPosition(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .zPosition, sideEffect: { $0.zPosition = $1 }).toAnyStyle
    }
    
    /**
     The anchor point for the layer’s position along the z axis. Animatable.
     
     This property specifies the anchor point on the z axis around which geometric manipulations occur.
     The point is expressed as a distance (measured in points) along the z axis. The default value of this
     property is 0.
     */
    public static func anchorPointZ(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .anchorPointZ, sideEffect: { $0.anchorPointZ = $1 }).toAnyStyle
    }
    
    /**
     Defines the anchor point of the layer's bounds rectangle. Animatable.
     
     You specify the value for this property using the unit coordinate space. The default value of this
     property is (0.5, 0.5), which represents the center of the layer’s bounds rectangle. All geometric
     manipulations to the view occur about the specified point. For example, applying a rotation transform
     to a layer with the default anchor point causes the layer to rotate around its center. Changing the
     anchor point to a different location would cause the layer to rotate around that new point.
     
     For more information about the relationship between the frame, bounds, anchorPoint and position
     properties, see Core Animation Programming Guide.
     */
    public static func anchorPoint(_ value: CGPoint) -> AnyStyle<T> {
        return ViewStyle(value, key: .anchorPoint, sideEffect: { $0.anchorPoint = $1 }).toAnyStyle
    }
    
    /**
     The scale factor applied to the layer.
     
     This value defines the mapping between the logical coordinate space of the layer (measured in points)
     and the physical coordinate space (measured in pixels). Higher scale factors indicate that each point
     in the layer is represented by more than one pixel at render time. For example, if the scale factor
     is 2.0 and the layer’s bounds are 50 x 50 points, the size of the bitmap used to present the layer’s
     content is 100 x 100 pixels.
     
     The default value of this property is 1.0. For layers attached to a view, the view changes the scale
     factor automatically to a value that is appropriate for the current screen. For layers you create and
     manage yourself, you must set the value of this property yourself based on the resolution of the screen
     and the content you are providing. Core Animation uses the value you specify as a cue to determine how
     to render your content.
     */
    public static func contentsScale(_ value: CGFloat) -> AnyStyle<T> {
        return ViewStyle(value, key: .contentsScale, sideEffect: { $0.contentsScale = $1 }).toAnyStyle
    }
    
    /**
     The name of the receiver.
     
     The layer name is used by some layout managers to identify a layer. The default value of this
     property is nil.
     */
    public static func name(_ value: String?) -> AnyStyle<T> {
        return ViewStyle(value, key: .name, sideEffect: { $0.name = $1 }).toAnyStyle
    }
}
