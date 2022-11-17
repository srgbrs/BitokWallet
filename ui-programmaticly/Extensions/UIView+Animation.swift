import Foundation
import UIKit

// Error shaking animation
extension UIView {
    func shake(duration: TimeInterval = 0.3, xValue: CGFloat = 12, yValue: CGFloat = 0) {
          self.transform = CGAffineTransform(translationX: xValue, y: yValue)
          UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
              self.transform = CGAffineTransform.identity
          }, completion: nil)

      }
}
