import CoreData

@objc(Reminder)
class Reminder:NSManagedObject{
    
    @NSManaged var id: NSNumber!
    @NSManaged var name:String!
    @NSManaged var time:Date!
    @NSManaged var date: Date!
}
