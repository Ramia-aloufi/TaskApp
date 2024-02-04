//
//  ContentView.swift
//  TaskApp
//
//  Created by ramia n on 06/04/1445 AH.
//

import SwiftUI

struct ContentView: View {
    @State var currentData: Date = Date()
    @State var weekSlider: [[Date.WeakDay]] = []
    @State var currentWeakIndex: Int = 1

    @Namespace var animation
    
    @State var createWeak:Bool = false
    @State var tasks :[Task] = []
    @State var createNewTask:Bool = false

    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Calendar")
                        .font(.system(size: 36, weight: .semibold))
                    TabView(selection: $currentWeakIndex,
                            content:  {
                        ForEach(weekSlider.indices, id: \.self) { index in
                            let week = weekSlider[index]
                            weekView(week)
                                .tag(index)
                        }
                    })
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 90)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background{
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .clipShape(.rect(bottomLeadingRadius: 30,bottomTrailingRadius: 30))
                        .ignoresSafeArea()
                }
                .onChange(of: currentWeakIndex, initial: false) { oldValue, newValue in
                    if newValue == 0  || newValue == (weekSlider.count - 1){
                        createWeak = true
                    }
                }
                ScrollView(.vertical) {
                    VStack{
                        TaskView(date: $currentData)
                    }
                    .hSpacing(.center)
                    .vSpacing(.center)
                }.scrollIndicators(.hidden)
                    .padding(.vertical)
            }
            .vSpacing(.top)
            .frame(maxWidth: .infinity)
            .onAppear() {
                if weekSlider.isEmpty {
                    let currentWeek = Date().fetchWeek()
                    if let firstday = currentWeek.first?.date{
                        print(firstday)
                        weekSlider.append(firstday.currentPerviosWeak())
                    }
                    
                    weekSlider.append(currentWeek)
                    
                    if let lastday = currentWeek.last?.date{
                        print(lastday)
                        weekSlider.append(lastday.currentNextWeak())
                        pagenateWeak()
                        createWeak = false
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    createNewTask.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding(26)
                        .background(.black)
                        .clipShape(Circle())
                        .padding(.horizontal)
                        .foregroundColor(.white)
                })
                .fullScreenCover(isPresented: $createNewTask, content: {
                    NewTask()
                })
            }
    }
    
    //Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeakDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week,id: \.id) { day in
                VStack {
                    Text(day.date.formate("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundColor(.gray)
                    Text(day.date.formate("dd"))
                        .font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundColor(isSameDate(day.date, currentData) ? .white : .black)
                        .background(content:{
                            if isSameDate(day.date, currentData){
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y:3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            if(day.date.isToday){
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5,height: 5)
                                    .vSpacing(.bottom)
                            }
                        })
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation {
                        currentData = day.date
                    }
                }
            }
        }
        .background{
            GeometryReader{
                let minX = $0.frame(in: .global).minX
                Color.clear.preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 15 && createWeak {
                            pagenateWeak()
                            createWeak = false
                        }
                    })
            }
        }
    }
    
    func pagenateWeak(){
        
        if weekSlider.indices.contains(currentWeakIndex){
            
            if let firstDate = weekSlider[currentWeakIndex].first?.date,currentWeakIndex == 0 {
                weekSlider.insert(firstDate.currentPerviosWeak(), at: 0)
                weekSlider.removeLast()
                currentWeakIndex  = 1
            }
            
            if let lastDate = weekSlider[currentWeakIndex].last?.date,currentWeakIndex == weekSlider.count - 1 {
                weekSlider.append(lastDate.currentNextWeak())
                weekSlider.removeFirst()
                currentWeakIndex  = weekSlider.count - 2
            }
        }
    }
}


#Preview {
    ContentView()
}
