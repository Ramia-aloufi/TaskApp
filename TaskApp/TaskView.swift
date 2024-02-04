//
//  TaskView.swift
//  TaskApp
//
//  Created by ramia n on 09/04/1445 AH.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    
    @Binding var date:Date
    @Query private var tasks:[Task]
        init(date:Binding<Date>){
            self._date = date
            let calender = Calendar.current
            let startDate = calender.startOfDay(for: date.wrappedValue)
            let endingDate = calender.date(byAdding: .day, value: 1, to: startDate)!
            let predicate = #Predicate<Task>{
                return $0.date >= startDate && $0.date < endingDate
            }
            let sortDescription = [SortDescriptor(\Task.date, order: .reverse)]
            self._tasks = Query(filter: predicate, sort: sortDescription ,animation: .snappy)
        }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ForEach(tasks) { task in
                TaskItem(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id{
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 24,y: 45)
                        }
                    }
            }
           

        })
        .padding(.top,15)
//        .overlay {
            if tasks.isEmpty{
                Text("No Tasks Added")
                    .font(.caption)
                    .frame(width: 150)
                
//            }
        }
    }
}

#Preview {
    ContentView()
}
