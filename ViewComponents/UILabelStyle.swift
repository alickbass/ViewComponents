//
//  UILabelStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 30/04/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum UILabelStyle: HashableConcreteStyle {
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
    
    public func sideEffect(on view: UILabel) {
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
    
    public static func == (lhs: UILabelStyle, rhs: UILabelStyle) -> Bool {
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
    
    var startIndex: Int { return 44 }
    
    var value: (index: Int, valueHash: Int) {
        switch self {
        case let .text(text):
            return (1, text?.hashValue ?? 0)
        case let .attributedText(text):
            return (2, text?.hashValue ?? 0)
        case let .font(font):
            return (3, font.hashValue)
        case let .textColor(textColor):
            return (4, textColor.hashValue)
        case let .textAlignment(textAlignment):
            return (5, textAlignment.hashValue)
        case let .lineBreakMode(lineBreakMode):
            return (6, lineBreakMode.hashValue)
        case let .isEnabled(isEnabled):
            return (7, isEnabled.hashValue)
        case let .adjustsFontSizeToFitWidth(adjusts):
            return (8, adjusts.hashValue)
        case let .allowsDefaultTighteningForTruncation(allows):
            return (9, allows.hashValue)
        case let .baselineAdjustment(adjustment):
            return (10, adjustment.hashValue)
        case let .minimumScaleFactor(minimumScaleFactor):
            return (11, minimumScaleFactor.hashValue)
        case let .numberOfLines(numberOfLines):
            return (12, numberOfLines.hashValue)
        case let .highlightedTextColor(highlightedTextColor):
            return (13, highlightedTextColor?.hashValue ?? 0)
        case let .isHighlighted(isHighlighted):
            return (14, isHighlighted.hashValue)
        case let .shadowColor(shadowColor):
            return (15, shadowColor?.hashValue ?? 0)
        case let .shadowOffset(shadowOffset):
            return (16, shadowOffset.hashValue)
        }
    }
}

public extension Component where T: UILabel {
    public func labelStyles(_ styles: UILabelStyle...) -> Component<T> {
        return add(styles: styles)
    }
}
