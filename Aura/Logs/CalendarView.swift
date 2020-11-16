//
//  CalendarView.swift
//  Aura
//
//  Created by Stevhen on 18/10/20.
//

import SwiftUI

struct LogsView: View {
    
    @Environment(\.calendar) var calendar
    
    @State var components = DateComponents()
    @State var selectedDate = Date()
    
    @State var logs: [LogDetail] = []
    
    private var year: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }
    
    func getCurrentDate(date : Date) -> String {
        return String(self.calendar.component(.day, from: date as Date))
    }
    
    func getCurrentDateMonthYear(date : Date) -> String {
        return "\(String(self.calendar.component(.day, from: date as Date)))-\(String(self.calendar.component(.month, from: date as Date)))-\(String(self.calendar.component(.year, from: date as Date)))"
    }
    
    func isToday(date : Date) -> Bool {
        return self.calendar.component(.day, from: date as Date) == self.calendar.component(.day, from: Date()) &&  self.calendar.component(.month, from: date as Date) == self.calendar.component(.month, from: Date())
    }
    
    func updateSelectedDate(date: Date) {
        selectedDate = date
    }
    
    func isDateSelected(date: Date) -> Bool {
        return
            getCurrentDateMonthYear(date: date) == getCurrentDateMonthYear(date: selectedDate)
    }
    
    func hasLogDetail(date: Date) -> Bool {
        for item in Log.fetchDummyData() {
            if DateFormatter.dayAndMonth.string(from: item.date) == DateFormatter.dayAndMonth.string(from: date) {
                //                DispatchQueue.main.async {
                //                    logs = item.logs
                //                }
                return true
            }
        }
        
        return false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                AuraColors.calendarBg
                    .zIndex(-1)
                
                CalendarView(interval: self.year) { date in
                    
                    VStack(spacing: 3) {
                        Text("30")
                            .hidden()
                            .padding(8)
                            .background(
                                isDateSelected(date: date) ?
                                    (isToday(date: date) ? AuraColors.orangeBall : AuraColors.solidPurple)
                                    : Color.clear
                            )
                            .clipShape(Circle())
                            .cornerRadius(4)
                            .overlay(
                                Text(getCurrentDate(date: date))
                                    .font(.custom("Graphik-Regular", size: 17))
                                    .foregroundColor(
                                        isDateSelected(date: date) ?
                                            Color.white :
                                            (isToday(date: date) ? AuraColors.orangeBall : AuraColors.dimBlack)
                                        
                                    )
                            )
                            .onTapGesture {
                                self.updateSelectedDate(date: date)
                            }
                        
                        Circle()
                            .foregroundColor(hasLogDetail(date: date) ? .gray : .clear)
                            .frame(width: 7, height: 7)
                        
                    }
                    .padding(.horizontal, 4)
                    
                }
                .padding()
                .border(AuraColors.calendarBg)
            }
            
            //            Spacer()
            DateDetailView(date: selectedDate)
            
        }
        
        .navigationBarTitle("Seizure Logs", displayMode: .inline)
    }
}

struct Log: Identifiable {
    var id: String = UUID().uuidString
    var date: Date
    var logs: [LogDetail]
    
    static func fetchDummyData() -> [Log] {
        return [
            Log(date: Date("2020/10/08"), logs: [LogDetail(location: "Rumah", duration: "1m 20s", type: "Tonic-Clonic")]),
            Log(date: Date("2020/10/17"), logs: [LogDetail(location: "Mall", duration: "1m 10s", type: "Tonic-Clonic")]),
            Log(date: Date("2020/10/11"), logs: [LogDetail(location: "Grand Indonesia", duration: "1m 50s", type: "Tonic")]),
            Log(date: Date("2020/10/18"), logs: [LogDetail(location: "Rumah Teman", duration: "2m 05s", type: "Clonic")]),
            Log(date: Date("2020/10/31"), logs: [LogDetail(location: "Rumah Teman", duration: "2m 05s", type: "Clonic")])
        ]
    }
}

struct LogDetail: Identifiable {
    var id: String = UUID().uuidString
    var location: String
    var duration: String
    var type: String
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
    static var dayAndMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM. d"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
    static var dayMonthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
    static var dateHour: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        return formatter
    }
    
}

fileprivate extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(startingAfter: interval.start,matching: components,matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
        else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    @State private var month: Date
    let showHeader: Bool
    let content: (Date) -> DateView
    
    init(
        month: Date,
        showHeader: Bool = true,
        localizedWeekdays: [String] = [],
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self._month = State(initialValue: month)
        self.content = content
        self.showHeader = showHeader
    }
    
    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return [] }
        
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    func changeDateBy(_ months: Int) {
        if let date = Calendar.current.date(byAdding: .month, value: months, to: month) {
            self.month = date
        }
    }
    
    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == -1 ? DateFormatter.month : .monthAndYear
        
        return HStack {
            
            Spacer()
            
            Button(action: {
                self.changeDateBy(-1)
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(Font.title3.bold())
                    .frame(width: 16, height: 18)
            }
            
            
            //            Spacer()
            
            Text(formatter.string(from: month))
                .font(.custom("Graphik-Regular", size: 20))
                .bold()
                .padding(.horizontal, 30)
            
            //            Spacer()
            
            Button(action: {
                self.changeDateBy(1)
            }) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .font(Font.title3.bold())
                    .frame(width: 16, height: 18)
            }
            
            Spacer()
            
            //            HStack{
            //                Group{
            //                    Button(action: {
            //                        self.changeDateBy(-1)
            //                    }) {
            //                        Image(systemName: "chevron.left.square") //
            //                            .resizable()
            //                    }
            //                    Button(action: {
            //                        self.month = Date()
            //                    }) {
            //                        Image(systemName: "dot.square")
            //                            .resizable()
            //                    }
            //                    Button(action: {
            //                        self.changeDateBy(1)
            //                    }) {
            //                        Image(systemName: "chevron.right.square") //"chevron.right.square"
            //                            .resizable()
            //                    }
            //                }
            //                .foregroundColor(Color.blue)
            //                .frame(width: 25, height: 25)
            //
            //            }
            //            .padding(.trailing, 20)
            //                        .hidden()
        }
        .foregroundColor(AuraColors.solidPurple)
        .padding(.vertical, 15)
    }
    
    var body: some View {
        VStack {
            
            if showHeader {
                header
            }
            
            HStack {
                ForEach(0 ..< 7, id: \.self) {index in
                    Text("30")
                        .hidden()
                        .padding(8)
                        .clipShape(Circle())
                        .padding(.horizontal, 4)
                        .overlay(
                            Text(getWeekDaysSorted()[index][0].uppercased()))
                        .foregroundColor(AuraColors.weekdaysHeader)
                }
            }
            
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width < 0 {
                        self.changeDateBy(1)
                    }
                    
                    if value.translation.width > 0 {
                        self.changeDateBy(-1)
                    }
                }))
    }
    
    func getWeekDaysSorted() -> [String]{
        //asdasaaaaa
        //        let weekDays = Calendar.current.shortWeekdaySymbols
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = NSLocale(localeIdentifier: UserDefaults.standard.string(forKey: "appLanguage") == "0" ? "id_ID" : "en_US_POSIX") as Locale
        
        let weekDays = calendar.veryShortWeekdaySymbols
        
        let sortedWeekDays = Array(
            weekDays[Calendar.current.firstWeekday - 1 ..< Calendar.current.shortWeekdaySymbols.count]
                +
                weekDays[0 ..< Calendar.current.firstWeekday - 1]
        )
        
        return sortedWeekDays
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let content: (Date) -> DateView
    
    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }
    
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        ForEach(months, id: \.self) { month in
            MonthView(month: month, content: self.content)
        }
    }
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
