//
//  String + ext.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/19/21.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
