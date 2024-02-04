//
//  NewTask.swift
//  TaskApp
//
//  Created by ramia n on 09/04/1445 AH.
//

import SwiftUI
import SwiftData

struct NewTask: View {
    @Environment (\.dismiss) var dismiss
    @Environment (\.modelContext) var context
    
    @State var taskTitle:String = ""
    @State var taskCaption:String = ""

    @State var taskDate:Date = .init()
    @State var taskColor:String = "TaskColor 1"
    

    var body: some View {
        VStack(alignment: .leading, content: {
            //Header
            VStack(alignment: .leading, content: {
                Label("Add New Task", systemImage: "arrow.left")
                    .onTapGesture {
                        dismiss()
                    }
            })
            .hSpacing(.leading)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background{
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30,bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            
            //Task title
            VStack(alignment: .leading,spacing: 30, content: {
                VStack(alignment: .leading,spacing: 20, content: {
                    TextField("Your title here", text: $taskTitle)
                    Divider()
                })
                VStack(alignment: .leading,spacing: 20, content: {
                    TextField("Your caption here", text: $taskCaption)
                    Divider()
                })
                VStack(alignment: .leading,spacing: 20, content: {
                    Text("Time line")
                        .font(.title2)
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                })
                       VStack(alignment: .leading,spacing: 20, content: {
                    Text("Task color")
                        .font(.title2)
                           let colors:[String] = (1...7).compactMap { index -> String in
                               return "TaskColor \(index)"
                           }
                    HStack(spacing: 10, content: {
                        ForEach(colors,id: \.self) { color in
                            Circle()
                                .fill(color.stringToColor().opacity(0.2))
                                .hSpacing(.center)
                                .background{
                                    Circle().stroke(lineWidth: 2).opacity(taskColor==color ? 1 : 0)
                                }
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                    
                                }
                        }
                    })
                })

            })
            .padding(30)
            .vSpacing(.top)
            
            Button {
                let task = Task(title: taskTitle, caption: taskCaption, tint: taskColor, date: taskDate )
                print(task)
                do{
                    context.insert(task)
                    try context.save()
                    dismiss()
                } catch{
                    print(error.localizedDescription)
                }
            }label: {
                Text("Add Task")
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 30))
                    .padding(.horizontal,30)
                
            }
            
        })
        .vSpacing(.top)
            
    }
}

#Preview {
    NewTask()
}
