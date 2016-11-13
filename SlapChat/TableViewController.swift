
import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    var messagesOfRecipient = [Message]()
    var selectedRecipient: Recipient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesOfRecipient = selectedRecipient?.messages?.allObjects as! [Message]
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        messagesOfRecipient = selectedRecipient?.messages?.allObjects as! [Message]
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesOfRecipient.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let eachMessage = messagesOfRecipient[indexPath.row]
        cell.textLabel?.text = eachMessage.content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMsgSegue" {
            if let dest = segue.destination as? AddMessageViewController {
                dest.selectedRecipient = self.selectedRecipient
                print("AHA!")
            }
        }
    }
}
