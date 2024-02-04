//
//  +View.swift
//  TaskApp
//
//  Created by ramia n on 06/04/1445 AH.
//

import Foundation
import SwiftUI
extension View{
    @ViewBuilder
    func hSpacing(_ alignment:Alignment) -> some View{
        self.frame(maxWidth: .infinity,alignment:alignment)
    }
    func vSpacing(_ alignment:Alignment) -> some View{
        self.frame(maxHeight: .infinity,alignment:alignment)
    }
    func isSameDate(_ date1:Date , _ date2:Date) ->Bool{
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
extension String{
    func stringToColor() -> Color{
            switch self{
            case "TaskColor 1": return .yellow
            case "TaskColor 2": return .green
            case "TaskColor 3": return .purple
            case "TaskColor 4": return .blue
            case "TaskColor 5": return .red
            case "TaskColor 6": return .indigo
            case "TaskColor 7": return .gray
            default:return .black
           
        }
    }
}
