//
//  Int+Extension.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/16/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation

extension Int {
    
    static func Currency(value: Int) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
}
