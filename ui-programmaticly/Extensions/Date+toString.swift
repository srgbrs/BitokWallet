
import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toString() -> String {
        let string = ""
        let components = self.get(.day, .month, .year)
        
        if let day = components.day, let month = components.month, let year = components.year {
            return "\(day)/\(month)"
        }
        return ""
    }
        
    
}
