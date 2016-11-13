
import UIKit

class RecipientListTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load in RecipientTableVC ")
        store.fetchDataForRecipients()
        print("fetched data in viewDidLoad in RecipientTableVC")
        tableView.reloadData()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        store.fetchDataForRecipients()
        print("fetched data in view will appear in RecipientTableVC")
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.recipients.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = store.recipients[indexPath.row].name
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMessage" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dest = segue.destination as! TableViewController
                dest.selectedRecipient = store.recipients[indexPath.row]

            }
        }
    }
}
    
    

