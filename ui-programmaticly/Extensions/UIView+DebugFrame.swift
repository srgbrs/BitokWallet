import Foundation
import UIKit

extension UIView {
    
    public enum DebugColor {
        case red
        case blue
        case green
    }
    
    func debugFrame(color: DebugColor) {
        
        var color: UIColor = UIColor.black
        switch color {
        case .red:
            color = UIColor.red
        case .blue:
            color = UIColor.blue
        case .green:
            color = UIColor.green
        default:
            color = UIColor.red
        }
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1.0
    }
}
