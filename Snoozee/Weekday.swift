//
//  Weekday.swift
//  Snoozee
//
//  Created by xnoag on 2023/05/30.
//

import Foundation

enum Weekday: String, Identifiable {
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thu = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
    
    var id: String {
       rawValue
    }
}
