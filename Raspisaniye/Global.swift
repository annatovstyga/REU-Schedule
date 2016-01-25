
import Foundation
import UIKit


let defaults = NSUserDefaults.standardUserDefaults()
var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()

struct GlobalColors{
    static let firstColor = UIColor(red: 212/255, green: 190/255, blue: 106/255, alpha: 1.0)
    static let secondColor = UIColor(red: 170/255,green: 143/255,blue: 57/255,alpha: 1.0)
    static let thirdColor = UIColor(red: 170/255,green: 143/255,blue: 57/255,alpha: 1.0)
    
}