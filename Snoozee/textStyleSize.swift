//
//  textStyleSize.swift
//  Snoozee
//
//  Created by SY AN on 2023/05/31.
//

import Foundation
import SwiftUI

public extension UIFont {
    static func textStyleSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}
