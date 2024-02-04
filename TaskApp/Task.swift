//
//  Task.swift
//  TaskApp
//
//  Created by ramia n on 06/04/1445 AH.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Task{
    let id:UUID
    let title:String
    let caption:String
    let date:Date
    var isCompleted:Bool
    let tint:String
    
    init(title: String ,id:UUID = .init() , caption: String,  isCompleted:Bool = false, tint: String, date:Date) {
        self.title = title
        self.caption = caption
        self.tint = tint
        self.id = id
        self.date = date
        self.isCompleted = isCompleted
    }
//    enum AppColor: String, CaseIterable {
//        case red, green, blue, yellow, orange
//    }
//    var tintColor:Color{
//        switch tinit{
//        case "TaskColor 1": return .yellow
//        case "TaskColor 2": return .green
//        case "TaskColor 3": return .purple
//        case "TaskColor 4": return .blue
//        case "TaskColor 5": return .red
//        case "TaskColor 6": return .indigo
//        case "TaskColor 7": return .gray
//        default:return .black
//        }
//    }
    
}


//var sampleText:[Task] = [
//    Task(title: "StandUp", caption: "Every day meeting", tinit: .yellow),
//    Task(title: "Kick Off", caption: "Travell App", tinit: .gray),
//    Task(title: "UI Design", caption: "Fintech App", tinit: .green),
//    Task(title: "Logo Design", caption: "Fintech App", tinit: .purple),
//
//]

extension Date{
    static func updateHour(_ value:Int)->Date{
        let callender = Calendar.current
        return callender.date(byAdding: .hour, value: value, to: .init()) ?? .init()
        
    }
}

