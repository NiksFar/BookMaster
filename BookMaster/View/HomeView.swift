//
//  HomeView.swift
//  BookMaster
//
//  Created by Nikita on 22.05.2026.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    
    //MARK: Calendar Property
    @State private var currentDate: Date = .init()
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = true
    @State private var weekSlider = [[Date.WeekDay]]()
    @State private var showProfileView: Bool = false
    // MARK: View Properties
    @Namespace private var animation
    @State private var showApproveView: Bool = false
    @State private var name: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: Header
            HeaderView()
            
            //MARK: TimeSlots
            ScrollView {
                VStack(spacing: 19) {
                    ForEach(TimeSlot.mockData) { slot in
                        TimeSlotCell(observed: .init(timeSlot: slot))
                    }
                }
            }
        }
        .onAppear {
            let currentWeek = Date().fetchWeek()
            if let firstDate = currentWeek.first?.date {
                weekSlider.append(firstDate.createPreviousWeek())
            }
            weekSlider.append(currentWeek)
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
        .overlay {
            if showProfileView {
                Rectangle()
                    .fill(.black.opacity(0.78))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showProfileView.toggle()
                    }
            }
        }
        .overlay {
            VStack(spacing: 45) {
                VStack(spacing: 27) {
                    TextField("name", text: $name)
                        .padding(.top, 109)
                        .font(.title.bold())
                        .padding(.bottom, -16)
                    LeafTextField(isSecure: false, title: "Your phone", text: $phone)
                    Text("Next appointments")
                        .font(.caption.bold())
                        .padding(.bottom, -16)
                    TabView {
                        
                    }
                        .frame(height: 75)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.bgGreen)
                        }
                        .tabViewStyle(.page)
                        .tint(.darkBlue)
                    LeafButton(title: "Previous Appointments") {
                        
                    }
                }
                
                .padding(.horizontal, 37)
                .padding(.bottom, 40)
                .background(.white)
                .clipShape(.rect(cornerRadii: .init(topLeading: 24,
                                                    bottomLeading: 0,
                                                    bottomTrailing: 48,
                                                    topTrailing: 80)))
                .overlay(alignment: .top) {
                    Image(.me)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 164, height: 164)
                        .clipShape(.circle)
                        .padding(11)
                        .background(Circle().fill(Color.white))
                        .offset(y: -93)
                }
                
                .padding(.horizontal, 21)
                Button("Quit account") {
                    
                }
                .foregroundStyle(.red)
            }
            .offset(y: showProfileView ? 0 : 1000)
            .animation(.easeInOut, value: showProfileView)
        }
        
    }
    
    @ViewBuilder func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.blue)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.darkGrey)
            }
            .font(.title.bold())
            Text(currentDate.formatted(date: .complete,
                                       time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.lightyGray)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    WeekView(weekSlider[index])
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
        
        .hSpacing(.leading)
        .padding()
        .background(.white)
        .overlay(alignment: .topTrailing) {
            Image(.me)
                .resizable()
                .frame(width: 52, height: 52)
                .scaledToFill()
                .clipShape(.circle)
                .offset(x: -19)
                .onTapGesture {
                    showProfileView.toggle()
                }
        }
    }
    
    @ViewBuilder func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { weekDay in
                VStack(spacing: 8) {
                    Text(weekDay.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.lightyGray)
                    Text(weekDay.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDay(weekDay.date, currentDate) ? .white : .darkGrey)
                        .frame(width: 36, height: 36)
                        .background {
                            if isSameDay(weekDay.date, currentDate) {
                                Circle()
                                    .fill(.darkBlue)
                            } else {
                                
                            }
                            
                            if weekDay.date.isToday {
                                Circle()
                                    .fill(.darkBlue)
                                    .frame(width: 6, height: 6)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation {
                        currentDate = weekDay.date
                    }
                }
            }
            
        }
        .background {
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX
                
                Color
                    .clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date,
            currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
        }
        if let lastDate = weekSlider[currentWeekIndex].last?.date,
           currentWeekIndex == weekSlider.count - 1 {
            weekSlider.append(lastDate.createNextWeek())
            currentWeekIndex = weekSlider.count - 2
        }
    }
    
}


#Preview {
    HomeView()
}

