
import UIKit
import CoreData

class AddRecipientViewController: UIViewController {
    
    var store = DataStore.sharedInstance
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let context = store.persistentContainer.viewContext
        let newRecipient = Recipient(context: context)
        
        if let text = textField.text {
            newRecipient.name = text
            
        }
        
        store.saveContext()
        print("saved Context in addRecipientVC")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

        override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
