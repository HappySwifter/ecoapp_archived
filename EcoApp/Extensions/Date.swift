//
//  Date.swift
//
//  Created by Артем Валиев on 17/04/2019.
//

import Foundation

public extension Date {
    
    // MARK:  NSDate Manipulation
    
    /**
     Returns a new NSDate object representing the date calculated by adding the amount specified to self date
     
     :param: seconds number of seconds to add
     :param: minutes number of minutes to add
     :param: hours number of hours to add
     :param: days number of days to add
     :param: weeks number of weeks to add
     :param: months number of months to add
     :param: years number of years to add
     :returns: the NSDate computed
     */
    func add(_ seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        let calendar = Calendar.current
        
        let version = floor(NSFoundationVersionNumber)
        
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = DateComponents()
            (component as NSDateComponents).setValue(seconds, forComponent: .second)
            
            var date : Date! = (calendar as NSCalendar).date(byAdding: component, to: self, options: [])!
            component = DateComponents()
            (component as NSDateComponents).setValue(minutes, forComponent: .minute)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(hours, forComponent: .hour)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(days, forComponent: .day)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(weeks, forComponent: .weekOfMonth)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(months, forComponent: .month)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(years, forComponent: .year)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            return date
        }
        
        var date : Date! = (calendar as NSCalendar).date(byAdding: .second, value: seconds, to: self, options: [])
        date = (calendar as NSCalendar).date(byAdding: .minute, value: minutes, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .day, value: days, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .hour, value: hours, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .weekOfMonth, value: weeks, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .month, value: months, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .year, value: years, to: date, options: [])
        return date
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
     
     :param: seconds number of seconds to add
     :returns: the NSDate computed
     */
     func addSeconds (_ seconds: Int) -> Date {
        return add(seconds)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
     
     :param: minutes number of minutes to add
     :returns: the NSDate computed
     */
     func addMinutes (_ minutes: Int) -> Date {
        return add(minutes: minutes)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
     
     :param: hours number of hours to add
     :returns: the NSDate computed
     */
     func addHours(_ hours: Int) -> Date {
        return add(hours: hours)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date
     
     :param: days number of days to add
     :returns: the NSDate computed
     */
     func addDays(_ days: Int) -> Date {
        return add(days: days)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
     
     :param: weeks number of weeks to add
     :returns: the NSDate computed
     */
     func addWeeks(_ weeks: Int) -> Date {
        return add(weeks: weeks)
    }
    
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date
     
     :param: months number of months to add
     :returns: the NSDate computed
     */
    
     func addMonths(_ months: Int) -> Date {
        return add(months: months)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date
     
     :param: years number of year to add
     :returns: the NSDate computed
     */
     func addYears(_ years: Int) -> Date {
        return add(years: years)
    }
    
    // MARK:  Date comparison
    
    /**
     Checks if self is after input NSDate
     
     :param: date NSDate to compare
     :returns: True if self is after the input NSDate, false otherwise
     */
     func isAfter(_ date: Date) -> Bool{
        return (self.compare(date) == ComparisonResult.orderedDescending)
    }
    
    /**
     Checks if self is before input NSDate
     
     :param: date NSDate to compare
     :returns: True if self is before the input NSDate, false otherwise
     */
     func isBefore(_ date: Date) -> Bool{
        return (self.compare(date) == ComparisonResult.orderedAscending)
    }
    
    
    // MARK: Getter
    
    /**
     Date year
     */
     var year : Int {
        get {
            return getComponent(component: .year)
        }
    }
    
    /**
     Date month
     */
     var month : Int {
        get {
            return getComponent(component: .month)
        }
    }
    
    /**
     Date weekday
     */
     var weekday : Int {
        get {
            return getComponent(component: .weekday)
        }
    }
    
    /**
     Date weekMonth
     */
     var weekMonth : Int {
        get {
            return getComponent(component: .weekOfMonth)
        }
    }
    
    
    /**
     Date days
     */
     var days : Int {
        get {
            return getComponent(component: .day)
        }
    }
    
    /**
     Date hours
     */
     var hours : Int {
        
        get {
            return getComponent(component: .hour)
        }
    }
    
    /**
     Date minuts
     */
     var minutes : Int {
        get {
            return getComponent(component: .minute)
        }
    }
    
    /**
     Date seconds
     */
     var seconds : Int {
        get {
            return getComponent(component: .second)
        }
    }
    
    /**
     Returns the value of the NSDate component
     
     :param: component NSCalendarUnit
     :returns: the value of the component
     */
    
     func getComponent (component:  Calendar.Component) -> Int {
        let calendar = NSCalendar.current
        return calendar.component(component, from: self)
    }
}


// func <(lhs: Date, rhs: Date) -> Bool {
//    return lhs.compare(rhs) == ComparisonResult.orderedAscending
//}





extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 0, day: -1), to: self.startOfMonth())!
    }
    
    var startOfWeek: Date {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var lastSunday: Date {
        return Calendar.gregorian.date(byAdding: DateComponents(weekOfYear: 0), to: startOfWeek)!
    }
    var nextSunday: Date {
        return Calendar.gregorian.date(byAdding: DateComponents(weekOfYear: -1), to: startOfWeek)!
    }
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

//let formatter = RelativeDateTimeFormatter()
//formatter.dateTimeStyle = .named
//
//formatter.localizedString(from: DateComponents(day: -1)) // "yesterday"
//formatter.localizedString(from: DateComponents(day: 1)) // "Tomorrow"
//formatter.localizedString(from: DateComponents(hour: 2)) // "in 2 hours"
//formatter.localizedString(from: DateComponents(minute: 45)) // "in 45 minutes"
