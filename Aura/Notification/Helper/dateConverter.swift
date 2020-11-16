//
//  durationToDate.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 16/10/20.
//

import Foundation

extension DateComponents {
    
    // MARK: - Get Time only from Date
    // get the time hh:mm from a date
    
    static func getTime(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .full
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter.string(from: date) //datetime
    }
    
    // MARK: - Get Time Diff of 2 Dates
    // convert duration/time interval (in sec) to date / time sign? (time diff)
    
    static func getInterval(startDate: Date) -> String {
        // code
        let interval = DateInterval(start: startDate, end: Date())
        let duration = durationToDate(duration: interval.duration)
        
        var result = ""
        
        switch duration.sign {
        case "days":
            if duration.days > 1 {
                result = "\(duration.days) " + NSLocalizedString("days ago", comment: "")
            } else {
                result = NSLocalizedString("yesterday", comment: "")
            }
            
        case "hours":
            if duration.hours > 1 {
                result = "\(duration.hours) " + NSLocalizedString("hours ago", comment: "")
            } else {
                result = NSLocalizedString("an hour ago", comment: "")
            }
            
        case "minutes":
            if duration.minutes > 1 {
                result = "\(duration.minutes) " + NSLocalizedString("minutes ago", comment: "")
            } else {
                result = NSLocalizedString("a minute ago", comment: "")
            }
            
        case "just now":
            result = NSLocalizedString("Just now", comment: "")
         
        case "weeks":
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd/MM/yyyy"
            result = dateFormatter.string(from: startDate)
            
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd/MM/yyyy"
            result = dateFormatter.string(from: startDate)
        }
                
        return result
    }

    struct durationToDate {
        var duration: Double
        
        var minutes: Int {
            return Int(duration / 60)
        }
        
        var hours: Int {
            return Int(minutes / 60)
        }
        
        var days: Int {
            return Int(hours / 24)
        }
        
        var sign: String {
            var x = ""
            if days > 0 {
                if days < 7 {
                    x = "days"
                } else {
                    x = "weeks"
                }
            } else {
                if hours > 0 {
                    x = "hours"
                } else {
                    if minutes > 0 {
                        x = "minutes"
                    } else {
                        x = "just now"
                    }
                }
            }
            return x
        }
        
        init(duration: Double) {
            self.duration = duration
        }
    }
}


