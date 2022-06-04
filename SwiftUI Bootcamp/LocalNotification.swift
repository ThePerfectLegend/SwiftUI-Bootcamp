//
//  LocalNotification.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 12.04.2022.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAutorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func sheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This is so easy!"
        content.sound = .default
        content.badge = 1
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)

        var dateComponents = DateComponents()
        dateComponents.hour = 17
        dateComponents.minute = 18
        dateComponents.weekday = 2
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let region = CLCircularRegion(
            center: CLLocationCoordinate2D(latitude: 43.64328343783467, longitude: 51.159643481759424),
            radius: 500,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: locationTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

}

struct LocalNotification: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAutorization()
            }
            Button("Shedule Notification") {
                NotificationManager.instance.sheduleNotification()
            }
            Button("Shedule Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}
