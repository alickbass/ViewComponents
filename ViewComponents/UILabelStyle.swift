//
//  UILabelStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 30/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UILabelStyle<T: UILabel>: KeyedStyle {
    public enum Key: Int, Hashable {
        case text = 44, attributedText, font
        case textColor, textAlignment, lineBreakMode
        case isEnabled, adjustsFontSizeToFitWidth, allowsDefaultTighteningForTruncation
        case baselineAdjustment, minimumScaleFactor, numberOfLines
        case highlightedTextColor, isHighlighted, shadowColor
        case shadowOffset
    }
    
    case text(String?)
    case attributedText(NSAttributedString?)
    case font(UIFont)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case lineBreakMode(NSLineBreakMode)
    case isEnabled(Bool)
    case adjustsFontSizeToFitWidth(Bool)
    case allowsDefaultTighteningForTruncation(Bool)
    case baselineAdjustment(UIBaselineAdjustment)
    case minimumScaleFactor(CGFloat)
    case numberOfLines(Int)
    case highlightedTextColor(UIColor?)
    case isHighlighted(Bool)
    case shadowColor(UIColor?)
    case shadowOffset(CGSize)
    
    public func sideEffect(on view: T) {
        switch self {
        case let .text(text):
            view.text = text
        case let .attributedText(text):
            view.attributedText = text
        case let .font(font):
            view.font = font
        case let .textColor(textColor):
            view.textColor = textColor
        case let .textAlignment(textAlignment):
            view.textAlignment = textAlignment
        case let .lineBreakMode(lineBreakMode):
            view.lineBreakMode = lineBreakMode
        case let .isEnabled(isEnabled):
            view.isEnabled = isEnabled
        case let .adjustsFontSizeToFitWidth(adjusts):
            view.adjustsFontSizeToFitWidth = adjusts
        case let .allowsDefaultTighteningForTruncation(allows):
            view.allowsDefaultTighteningForTruncation = allows
        case let .baselineAdjustment(adjustment):
            view.baselineAdjustment = adjustment
        case let .minimumScaleFactor(minimumScaleFactor):
            view.minimumScaleFactor = minimumScaleFactor
        case let .numberOfLines(numberOfLines):
            view.numberOfLines = numberOfLines
        case let .highlightedTextColor(highlightedTextColor):
            view.highlightedTextColor = highlightedTextColor
        case let .isHighlighted(isHighlighted):
            view.isHighlighted = isHighlighted
        case let .shadowColor(shadowColor):
            view.shadowColor = shadowColor
        case let .shadowOffset(shadowOffset):
            view.shadowOffset = shadowOffset
        }
    }
    
    public static func == (lhs: UILabelStyle<T>, rhs: UILabelStyle<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.text(leftText), .text(rightText)):
            return leftText == rightText
        case let (.attributedText(leftText), .attributedText(rightText)):
            return leftText == rightText
        case let (.font(leftFont), .font(rightFont)):
            return leftFont == rightFont
        case let (.textColor(leftColor), .textColor(rightColor)):
            return leftColor == rightColor
        case let (.textAlignment(leftTextAlignment), .textAlignment(rightTextAlignment)):
            return leftTextAlignment == rightTextAlignment
        case let (.lineBreakMode(leftMode), .lineBreakMode(rightMode)):
            return leftMode == rightMode
        case let (.isEnabled(leftBool), .isEnabled(rightBool)),
             let (.adjustsFontSizeToFitWidth(leftBool), .adjustsFontSizeToFitWidth(rightBool)),
             let (.allowsDefaultTighteningForTruncation(leftBool), .allowsDefaultTighteningForTruncation(rightBool)),
             let (.isHighlighted(leftBool), .isHighlighted(rightBool)):
            return leftBool == rightBool
        case let (.baselineAdjustment(leftAdjustment), .baselineAdjustment(rightAdjustment)):
            return leftAdjustment == rightAdjustment
        case let (.minimumScaleFactor(leftFactor), .minimumScaleFactor(rightFactor)):
            return leftFactor == rightFactor
        case let (.numberOfLines(leftNumberOfLines), .numberOfLines(rightNumberOfLines)):
            return leftNumberOfLines == rightNumberOfLines
        case let (.highlightedTextColor(leftColor), .highlightedTextColor(rightColor)),
             let (.shadowColor(leftColor), .shadowColor(rightColor)):
            return leftColor == rightColor
        case let (.shadowOffset(leftOffset), .shadowOffset(rightOffset)):
            return leftOffset == rightOffset
        default:
            return false
        }
    }
    
    @inline(__always) public func value() -> (key: Key, valueHash: Int) {
        switch self {
        case let .text(text):
            return (.text, text?.hashValue ?? 0)
        case let .attributedText(text):
            return (.attributedText, text?.hashValue ?? 0)
        case let .font(font):
            return (.font, font.hashValue)
        case let .textColor(textColor):
            return (.textColor, textColor.hashValue)
        case let .textAlignment(textAlignment):
            return (.textAlignment, textAlignment.hashValue)
        case let .lineBreakMode(lineBreakMode):
            return (.lineBreakMode, lineBreakMode.hashValue)
        case let .isEnabled(isEnabled):
            return (.isEnabled, isEnabled.hashValue)
        case let .adjustsFontSizeToFitWidth(adjusts):
            return (.adjustsFontSizeToFitWidth, adjusts.hashValue)
        case let .allowsDefaultTighteningForTruncation(allows):
            return (.allowsDefaultTighteningForTruncation, allows.hashValue)
        case let .baselineAdjustment(adjustment):
            return (.baselineAdjustment, adjustment.hashValue)
        case let .minimumScaleFactor(minimumScaleFactor):
            return (.minimumScaleFactor, minimumScaleFactor.hashValue)
        case let .numberOfLines(numberOfLines):
            return (.numberOfLines, numberOfLines.hashValue)
        case let .highlightedTextColor(highlightedTextColor):
            return (.highlightedTextColor, highlightedTextColor?.hashValue ?? 0)
        case let .isHighlighted(isHighlighted):
            return (.isHighlighted, isHighlighted.hashValue)
        case let .shadowColor(shadowColor):
            return (.shadowColor, shadowColor?.hashValue ?? 0)
        case let .shadowOffset(shadowOffset):
            return (.shadowOffset, shadowOffset.hashValue)
        }
    }
}

public extension Component where T: UILabel {
    public func label(_ styles: UILabelStyle<T>...) -> Component<T> {
        return adding(styles: styles.lazy.map(AnyStyle.init))
    }
}
