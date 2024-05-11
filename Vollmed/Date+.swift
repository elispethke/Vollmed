//
//  Date+.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 03.05.24.
//

import Foundation
extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
