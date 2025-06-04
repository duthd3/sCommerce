//
//  Numeric+Extensions.swift
//  sCommerce
//
//  Created by yeosong on 6/4/25.
//

import Foundation

extension Numeric {
    var moneyString: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return (formatter.string(for: self) ?? "") + "원"
    }
}
