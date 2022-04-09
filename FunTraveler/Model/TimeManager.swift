//
//  TimeManager.swift
//  TestPlanningCell
//
//  Created by 林翊婷 on 2022/4/3.
//

import Foundation
import UIKit

class TimeManager {
    
    static func getDateFromString(dateFormat: String, dateString: String, duration: Double) throws -> Time {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.local
        
        guard let date = dateFormatter.date(from: dateString) else {
            throw ClientError.invalidDateOfTime
        }
        

        let newDate = date + duration*3600

        let calendar = Calendar.current
        
        let startHours = calendar.component(.hour, from: date)
        let startMinutes = calendar.component(.minute, from: date)
        
        let endHours = calendar.component(.hour, from: newDate)
        let endMinutes = calendar.component(.minute, from: newDate)
        
        
        return Time(startHours: startHours, startMinutes: startMinutes, duration: duration, endHours: endHours, endMinutes: endMinutes)
    }
}

struct Time {
    var startHours: Int
    var startMinutes: Int
    
    var duration: Double
    
    var endHours: Int
    var endMinutes: Int
    
}


enum ClientError :Error{
    case invalidDateOfTime
}

//糞code before
//
//func succesess() {
//    let dateString = "2017-02-09 15:51:07"
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//
//    guard let date = dateFormatter.date(from: dateString) else {
//        fatalError("Unable to create date from string \(dateString) with format \(dateFormatter.dateFormat)")
//    }
//
//    var dateTwo = date+60
//
//    let calendar = Calendar.current
//    let hour = calendar.component(.hour, from: dateTwo)
//    let minute = calendar.component(.minute, from: dateTwo)
//}
//
