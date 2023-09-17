import UIKit
import CoreData

class ReminderDetail: UIViewController{
    
    
    
    @IBOutlet weak var reminderDate: UIDatePicker!
    @IBOutlet weak var reminderTime: UIDatePicker!
    @IBOutlet weak var reminderName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveActionButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        let newReminder = Reminder(entity: entity!, insertInto: context)
        
        newReminder.id = reminderList.count as NSNumber
        newReminder.time = reminderTime.date
        newReminder.date = reminderDate.date
        newReminder.name = reminderName.text
       
        
        do {
            try context.save()
            reminderList.append(newReminder)
            navigationController?.popViewController(animated: true)
            scheduleReminderNotification(reminder: newReminder)
        }
        catch{
            print("context save error ")
        }
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

