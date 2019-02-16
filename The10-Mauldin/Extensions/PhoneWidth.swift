//
//  UIscreen+Extension.swift
//  The10-Mauldin
//
//  Created by Chris Mauldin on 2/16/19.
//  Copyright © 2019 Chris Mauldin. All rights reserved.
//

import Foundation
import UIKit
enum PhoneWidth: Int {
    case SE = 320
    case Eight = 375
    case EightPlus = 414
    
    static func movieListCellSize() -> CGSize {
        let width = Int(UIScreen.main.bounds.width)
        switch PhoneWidth(rawValue: width)! {
        case .SE:
            return CGSize(width: 150, height: 154)
        case .Eight:
            return CGSize(width: 163, height: 201)
        case .EightPlus:
            return CGSize(width: 168, height: 209)
        }
    }
    
    static func movieTypeCellSize() -> CGSize {
        let width = Int(UIScreen.main.bounds.width)
        switch PhoneWidth(rawValue: width)! {
        case .SE:
            return CGSize(width: 285, height: 350)
        case .Eight:
            return CGSize(width: 350, height: 436)
        case .EightPlus:
            return CGSize(width: 370, height: 436)
        }
        
        
    }
}


