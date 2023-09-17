import UIKit
import CoreData
import UserNotifications

var reminderList = [Reminder]()

class ReminderTableView: UITableViewController{
    
    var firstLoad = true
    
    override func viewDidLoad()
        {
            if(firstLoad)
            {
                firstLoad = false
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results
                    {
                        let reminder = result as! Reminder
                        reminderList.append(reminder)
                        scheduleReminderNotification(reminder: reminder)
                    }
                }
                catch
                {
                    print("Fetch Failed")
                }
            }
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminderCell = tableView.dequeueReusableCell(withIdentifier: "reminderCellID",for: indexPath) as! ReminderCell
        
        let thisReminder: Reminder!
        thisReminder = reminderList[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" 
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"

        reminderCell.reminderName.text = thisReminder.name
        reminderCell.reminderDate.text = dateFormatter.string(from:thisReminder.date)
        reminderCell.reminderTime.text = timeFormatter.string(from: thisReminder.time)
        
        return reminderCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return reminderList.count
        }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    func scheduleReminderNotification(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = reminder.name
        
        // Create a calendar object for the current date and time
        let currentCalendar = Calendar.current
        let currentDate = Date()
        
        // Check if the reminder's date is in the past
        if currentCalendar.compare(currentDate, to: reminder.time, toGranularity: .minute) == .orderedDescending {
            // The reminder's date is in the past, so skip scheduling the notification
            print("Reminder date is in the past. Notification not scheduled.")
            return
        }
        
        // The reminder's date is in the future, so proceed to schedule the notification
        
        // Create a calendar object for the reminder's time
        let reminderCalendar = Calendar.current
        let components = reminderCalendar.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
