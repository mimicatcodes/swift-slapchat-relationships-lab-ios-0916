
import UIKit
import CoreData

class AddMessageViewController: UIViewController {
    
    var store = DataStore.sharedInstance
    var selectedRecipient : Recipient?
    @IBOutlet weak var addMessageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveMessageButtonTapped(_ sender: AnyObject) {
        
        let context = store.persistentContainer.viewContext
        let newMessage = Message(context: context)
        
        if let text = addMessageTextField.text {
            newMessage.content = text
        }
        newMessage.createdAt = NSDate()
        newMessage.recipient = selectedRecipient
        store.saveContext()
        store.fetchData()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

