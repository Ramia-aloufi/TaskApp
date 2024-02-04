//
//  DataExtension.swift
//  TaskApp
//
//  Created by ramia n on 06/04/1445 AH.
//

import Foundation

extension Date{
    func formate(_ formate:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter.string(from: self )
    }
    
    struct WeakDay {
        let id:UUID = .init()
        let date :Date
    }
    
    var isToday:Bool{
        return Calendar.current.isDateInToday(self)
    }
    var isSameHour:Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    var isPast:Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }

    
    func fetchWeek(_ date:Date = .init()) -> [WeakDay]{
        let callender = Calendar.current
        let startDate = callender.startOfDay(for: date)
        
        var week:[WeakDay] = []
        let weakDate = callender.dateInterval(of: .weekOfMonth, for: startDate)
        
        guard (weakDate?.start) != nil else {
            return []
        }
        
        (0..<7).forEach { index in
            if let weakDay = callender.date(byAdding: .day, value: index, to: startDate){
                week.append(.init(date: weakDay))
            }
        }
        return week
        
    }
    
    func currentNextWeak()->[WeakDay]{
        let callender = Calendar.current
        let startLastDate = callender.startOfDay(for: self)
        guard let nextDate = callender.date(byAdding: .day, value: 1, to: startLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    func currentPerviosWeak()->[WeakDay]{
        let callender = Calendar.current
        let startLastDate = callender.startOfDay(for: self)
        guard let nextDate = callender.date(byAdding: .day, value: -1, to: startLastDate) else {
            return []
        } 
        return fetchWeek(nextDate)
    }
}

