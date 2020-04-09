//
//  UIColor + Extension.swift
//  ToDo List
//
//  Created by Alexander on 05.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var ColorMap: [String: UIColor] = [
        "Yellow": TaskColor.yellow,
        "Gray": TaskColor.gray,
        "Red": TaskColor.red,
        "Blue": TaskColor.blue,
        "Green": TaskColor.green,
        "Black": TaskColor.black,
        "Pink": TaskColor.pink,
        "Orange": TaskColor.orange
    ]
    
    enum Colors: String, CaseIterable {
        case Yellow = "Yellow"
        case Gray = "Gray"
        case Red = "Red"
        case Blue = "Blue"
        case Green = "Green"
        case Black = "Black"
        case Pink = "Pink"
        case Orange = "Orange"
    }
    
    struct TaskColor {
        static var yellow: UIColor { return UIColor.rgb(red: 198, green: 255, blue: 0) }
        static var gray: UIColor { return UIColor.rgb(red: 106, green: 106, blue: 106) }
        static var red: UIColor { return UIColor.rgb(red: 255, green: 0, blue: 0) }
        static var blue: UIColor { return UIColor.rgb(red: 67, green: 0, blue: 255) }
        static var green: UIColor { return UIColor.rgb(red: 0, green: 101, blue: 41) }
        static var black: UIColor { return UIColor.rgb(red: 6, green: 6, blue: 6) }
        static var pink: UIColor { return UIColor.rgb(red: 255, green: 0, blue: 184) }
        static var orange: UIColor { return UIColor.rgb(red: 255, green: 156, blue: 0) }
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
