import Foundation
import CoreData

class DataStore {
    
    var messages:[Message] = []
    var recipients:[Recipient] = []
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Core Data Fetching support
    
    
    func fetchDataForRecipients(){
        let context = persistentContainer.viewContext
        let recipientsRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        
        do {
            recipients = try context.fetch(recipientsRequest)
            recipients.sort(by: { (recipient1, recipient2) -> Bool in
                if let name1 = recipient1.name, let name2 = recipient2.name {
                    return name1 < name2
                    
                }
                return false
            })
            
        } catch let error{
            print("Error fetching data: \(error)")
            recipients = []
            
        }
    }
    func fetchData() {
        let context = persistentContainer.viewContext
        let messagesRequest: NSFetchRequest<Message> = Message.fetchRequest()
        
        do {
            messages = try context.fetch(messagesRequest)
            messages.sort(by: { (message1, message2) -> Bool in
                let date1 = message1.createdAt! as Date
                let date2 = message2.createdAt! as Date
                return date1 < date2
            })
        } catch let error {
            print("Error fetching data: \(error)")
            messages = []
        }
        
        if messages.count == 0 {
            generateTestData()
        }
    }
    
    // MARK: - Core Data generation of test data
    
    func generateTestData() {
        let context = persistentContainer.viewContext
        
        let messageOne: Message = Message(context: context)
        
        messageOne.content = "Message 1"
        messageOne.createdAt = NSDate()
        
        let messageTwo: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        messageTwo.content = "Message 2"
        messageTwo.createdAt = NSDate()
        
        let messageThree: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        messageThree.content = "Message 3"
        messageThree.createdAt = NSDate()
        
        saveContext()
        fetchData()
    }
    
}

extension Message {
    static func newMessage(withCotent content:String, createdAt:NSData) -> Message{
        let newMessage = Message(context: DataStore.sharedInstance.persistentContainer.viewContext)
        
        newMessage.content = content
        newMessage.createdAt = NSDate()
        return newMessage
    }
}
