//
//  CALayerStyle.swift
//  ViewComponents
//
//  Created by Oleksii on 04/05/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import UIKit

public enum CAGravity: RawRepresentable {
    case center, top, bottom, left, right
    case topLeft, topRight
    case bottomLeft, bottomRight
    case resize, resizeAspect, resizeAspectFill
    
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
        case kCAGravityCenter:
            self = .center
        case kCAGravityTop:
            self = .top
        case kCAGravityBottom:
            self = .bottom
        case kCAGravityLeft:
            self = .left
        case kCAGravityRight:
            self = .right
        case kCAGravityTopLeft:
            self = .topLeft
        case kCAGravityTopRight:
            self = .topRight
        case kCAGravityBottomLeft:
            self = .bottomLeft
        case kCAGravityBottomRight:
            self = .bottomRight
        case kCAGravityResize:
            self = .resize
        case kCAGravityResizeAspect:
            self = .resizeAspect
        case kCAGravityResizeAspectFill:
            self = .resizeAspectFill
        default:
            return nil
        }
    }
}
