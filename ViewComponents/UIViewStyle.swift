//
//  UIViewStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 26/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

private enum UIViewStyleKey: Int, StyleKey {
    case backgroundColor = 50, isHidden, alpha
    case isOpaque, tintColor, tintAdjustmentMode
    case clipsToBounds, clearsContextBeforeDrawing, isUserInteractionEnabled
    case isMultipleTouchEnabled, isExclusiveTouch, contentMode, layoutMargins
    case preservesSuperviewLayoutMargins, semanticContentAttribute
}

public extension AnyStyle where T: UIView {
    private typealias ViewStyle<Item> = Style<T, Item, UIViewStyleKey>
    
    /**
     The view’s background color.
     
     Changes to this property can be animated. The default value is nil, which results in a
     transparent background color.
     */
    public static func backgroundColor(_ color: UIColor? = nil) -> AnyStyle<T> {
        return ViewStyle(color, key: .backgroundColor, sideEffect: {  $0.backgroundColor = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that determines whether the view is hidden.
     
     Setting the value of this property to true hides the receiver and setting it to false shows
     the receiver. The default value is false.
     
     A hidden view disappears from its window and does not receive input events. It remains in its
     superview’s list of subviews, however, and participates in autoresizing as usual. Hiding a view
     with subviews has the effect of hiding those subviews and any view descendants they might have.
     This effect is implicit and does not alter the hidden state of the receiver’s descendants.
     
     Hiding the view that is the window’s current first responder causes the view’s next valid key view
     to become the new first responder.
     
     The value of this property reflects the state of the receiver only and does not account for the
     state of the receiver’s ancestors in the view hierarchy. Thus this property can be false but the
     receiver may still be hidden if an ancestor is hidden.
     */
    public static func isHidden(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isHidden, sideEffect: { $0.isHidden = $1 }).toAnyStyle
    }
    
    /**
     The view’s alpha value.
     
     The value of this property is a floating-point number in the range 0.0 to 1.0, where 0.0 represents
     totally transparent and 1.0 represents totally opaque. Changing the value of this property updates
     the alpha value of the current view only. However, the transparency imparted by that alpha value
     affects all of the view's contents, including its subviews. For example, a subview with an alpha
     value of 1.0 that is embedded in a parent view with an alpha value of 0.5, appears onscreen as if
     its alpha value is also 0.5.
     
     Changes to this property can be animated.
     */
    public static func alpha(_ alpha: CGFloat) -> AnyStyle<T> {
        return ViewStyle(alpha, key: .alpha, sideEffect: { $0.alpha = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that determines whether the view is opaque.
     
     This property provides a hint to the drawing system as to how it should treat the view. If set to true,
     the drawing system treats the view as fully opaque, which allows the drawing system to optimize some
     drawing operations and improve performance. If set to false, the drawing system composites the view
     normally with other content. The default value of this property is true.
     
     An opaque view is expected to fill its bounds with entirely opaque content—that is, the content should
     have an alpha value of 1.0. If the view is opaque and either does not fill its bounds or contains wholly
     or partially transparent content, the results are unpredictable. You should always set the value of this
     property to false if the view is fully or partially transparent.
     
     You only need to set a value for the opaque property in subclasses of UIView that draw their own content
     using the draw(_:) method. The opaque property has no effect in system-provided classes such as UIButton,
     UILabel, UITableViewCell, and so on.
     */
    public static func isOpaque(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isOpaque, sideEffect: { $0.isOpaque = $1 }).toAnyStyle
    }
    
    /**
     The first nondefault tint color value in the view’s hierarchy, ascending from and starting with the view itself.
     
     If the system cannot find a nondefault color in the hierarchy, this property’s value is a system-defined
     color instead.
     
     If the view’s tintAdjustmentMode property’s value is dimmed, then the tintColor property value is
     automatically dimmed.
     
     To refresh subview rendering when this property changes, override the tintColorDidChange() method.
     
     Colors that are pattern colors (as described in UIColor) are not supported.
     
     **Important**
     
     If you attempt to use a pattern color as a tint color, the system raises an exception.
     */
    public static func tintColor(_ color: UIColor) -> AnyStyle<T> {
        return ViewStyle(color, key: .tintColor, sideEffect: { $0.tintColor = $1 }).toAnyStyle
    }
    
    /**
     The first non-default tint adjustment mode value in the view’s hierarchy, ascending from and starting with
     the view itself.
     
     When this property’s value is dimmed, the value of the tintColor property is modified to provide a dimmed appearance.
     
     If the system cannot find a non-default value in the subview hierarchy when you query this property,
     the value is normal.
     
     When this property’s value changes (either by the view’s value changing or by one of its superview’s values
     changing), -the system calls the tintColorDidChange() method to allow the view to refresh its rendering.
     */
    public static func tintAdjustmentMode(_ mode: UIViewTintAdjustmentMode) -> AnyStyle<T> {
        return ViewStyle(mode, key: .tintAdjustmentMode, sideEffect: { $0.tintAdjustmentMode = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that determines whether subviews are confined to the bounds of the view.
     
     Setting this value to true causes subviews to be clipped to the bounds of the receiver. If set to false,
     subviews whose frames extend beyond the visible bounds of the receiver are not clipped. The default value is false.
     */
    public static func clipsToBounds(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clipsToBounds, sideEffect: { $0.clipsToBounds = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that determines whether the view’s bounds should be automatically cleared before drawing.
     
     When set to true, the drawing buffer is automatically cleared to transparent black before the draw(_:) method
     is called. This behavior ensures that there are no visual artifacts left over when the view’s contents are redrawn.
     If the view’s isOpaque property is also set to true, the backgroundColor property of the view must not be nil or
     drawing errors may occur. The default value of this property is true.
     
     If you set the value of this property to false, you are responsible for ensuring the contents of the view are drawn
     properly in your draw(_:) method. If your drawing code is already heavily optimized, setting this property is false
     can improve performance, especially during scrolling when only a portion of the view might need to be redrawn.
     */
    public static func clearsContextBeforeDrawing(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .clearsContextBeforeDrawing, sideEffect: { $0.clearsContextBeforeDrawing = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that determines whether user events are ignored and removed from the event queue.
     
     When set to false, touch, press, keyboard, and focus events intended for the view are ignored and removed from the
     event queue. When set to true, events are delivered to the view normally. The default value of this property is true.
     
     During an animation, user interactions are temporarily disabled for all views involved in the animation, regardless
     of the value in this property. You can disable this behavior by specifying the allowUserInteraction option when
     configuring the animation.
     
     **Note**
     
     Some UIKit subclasses override this property and return a different default value. See the documentation for that
     class to determine if it returns a different value.
     */
    public static func isUserInteractionEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isUserInteractionEnabled, sideEffect: { $0.isUserInteractionEnabled = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that indicates whether the view receives more than one touch at a time.
     
     When set to true, the view receives all touches associated with a multi-touch sequence and starting
     within the view's bounds. When set to false, the view receives only the first touch event in a
     multi-touch sequence that start within the view's bounds. The default value of this property is false.
     
     **Note**
     
     This property does not affect the gesture recognizers attached to the view. Gesture recognizers receive
     all touches that occur in the view.
     
     Other views in the same window can still receive touch events when this property is false. If you want
     this view to handle multi-touch events exclusively, set the values of both this property and the
     isExclusiveTouch property to true. This property does not prevent a view from being asked to handle multiple
     touches. For example, two subviews may both forward their touches to a common parent, such as a window or the
     root view of a view controller. This property determines how many touches initially targeting the view are
     delivered to that view.
     */
    public static func isMultipleTouchEnabled(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isMultipleTouchEnabled, sideEffect: { $0.isMultipleTouchEnabled = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value that indicates whether the receiver handles touch events exclusively.
     
     Setting this property to true causes the receiver to block the delivery of touch events to other views in the
     same window. The default value of this property is false.
     */
    public static func isExclusiveTouch(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .isExclusiveTouch, sideEffect: { $0.isExclusiveTouch = $1 }).toAnyStyle
    }
    
    /**
     A flag used to determine how a view lays out its content when its bounds change.
     
     The content mode specifies how the cached bitmap of the view’s layer is adjusted when the view’s bounds
     change. This property is often used to implement resizable controls. Instead of redrawing the contents of
     the view every time, you can use this property to specify that you want to scale the contents (either with
     or without distortion) or pin them to a particular spot on the view.
     
     **Note**
     
     You can always force the contents of a view to be redrawn by calling the setNeedsDisplay() or
     setNeedsDisplay(_:) method.
     
     For a list of values you can assign to this property, see UIViewContentMode. The default value of this
     property is scaleToFill.
     */
    public static func contentMode(_ mode: UIViewContentMode) -> AnyStyle<T> {
        return ViewStyle(mode, key: .contentMode, sideEffect: { $0.contentMode = $1 }).toAnyStyle
    }
    
    /**
     The default spacing to use when laying out content in the view.
     
     In iOS 11 and later, use the directionalLayoutMargins property to specify layout margins instead of this
     property. The leading and trailing edge insets in the directionalLayoutMargins property are synchronized
     with the left and right insets in this property. For example, setting the leading directional edge inset
     to 20 points causes the left inset of this property to be set to 20 points on a system with a left-to-right
     language.
     
     For the root view of a view controller, the default value of this property reflects the system minimum
     margins and safe area insets. For other subviews in your view hierarchy, the default layout margins are
     normally 8 points on each side, but the values may be greater if the view is not fully inside the safe
     area or if the preservesSuperviewLayoutMargins property is true.
     
     This property specifies the desired amount of space (measured in points) between the edge of the view and
     any subviews. Auto layout uses your margins as a cue for placing content. For example, if you specify a set
     of horizontal constraints using the format string “|-[subview]-|”, the left and right edges of the subview
     are inset from the edge of the superview by the corresponding layout margins. When the edge of your view is
     close to the edge of the superview and the preservesSuperviewLayoutMargins property is true, the actual
     layout margins may be increased to prevent content from overlapping the superview’s margins.
     */
    public static func layoutMargins(_ value: UIEdgeInsets) -> AnyStyle<T> {
        return ViewStyle(value, key: .layoutMargins, sideEffect: { $0.layoutMargins = $1 }).toAnyStyle
    }
    
    /**
     A Boolean value indicating whether the current view also respects the margins of its superview.
     
     When the value of this property is true, the superview’s margins are also considered when laying out content.
     This margin affects layouts where the distance between the edge of a view and its superview is smaller than
     the corresponding margin. For example, you might have a content view whose frame precisely matches the bounds
     of its superview. When any of the superview’s margins is inside the area represented by the content view and
     its own margins, UIKit adjusts the content view’s layout to respect the superview’s margins. The amount of the
     adjustment is the smallest amount needed to ensure that content is also inside the superview’s margins.
     
     The default value of this property is false.
     */
    public static func preservesSuperviewLayoutMargins(_ value: Bool) -> AnyStyle<T> {
        return ViewStyle(value, key: .preservesSuperviewLayoutMargins, sideEffect: { $0.preservesSuperviewLayoutMargins = $1 }).toAnyStyle
    }
    
    /**
     A semantic description of the view’s contents, used to determine whether the view should be flipped when
     switching between left-to-right and right-to-left layouts.
     
     Some views should not flip when switching between left-to-right and right-to-left layouts. For example, the view
     is part of the playback controls or represents physical directions (up, down, left, right) that don’t change.
     Instead of thinking about whether or not a view should change its orientation, select the semantic content
     attribute that best describes your view.
     
     When creating a view that contains subviews, you can use the userInterfaceLayoutDirection(for:) class method
     to determine whether the subviews should be flipped, and lay out the views in the appropriate order.
     
     For a list of possible values, see UISemanticContentAttribute.
     */
    public static func semanticContentAttribute(_ value: UISemanticContentAttribute) -> AnyStyle<T> {
        return ViewStyle(value, key: .semanticContentAttribute, sideEffect: { $0.semanticContentAttribute = $1 }).toAnyStyle
    }
}
