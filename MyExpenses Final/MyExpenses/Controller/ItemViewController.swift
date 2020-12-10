//
//  ItemViewController.swift
//  Expenses App with Core Data
//
//  Created by Temesgen Daniel on 01/12/2020.
//
import UIKit
import CoreData

class ItemViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)

    }
    
    @IBOutlet weak var totalExpense: UILabel!
    var myTotal: Double = 0.0
    
    //MARK - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTotal = 0.0  // reset total expeneses to ZERO before each reload
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = "\(item.title!)\t\t\t\t\t\t\t\(item.price) AED"
       
        myTotal += item.price
        totalExpense.text = "Total Expenes: \(myTotal) AED"
        //cell.textLabel?.text = item.price

        return cell

    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       
        if (editingStyle == .delete) {
            
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            
            do {
                try context.save()
            } catch {
                print("Error deleting Expense with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)  //includes updating UI so reloading is not necessary
        }
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        var textField_2 = UITextField()

        let alert = UIAlertController(title: "Add new Expenes", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What happens when the user clicks the add item button
            //We are in a closure so we need to use the keyword self
            
            
            let newItem = Item(context: self.context)
            if(textField.text! != ""){
            
                newItem.title = textField.text!
                if textField_2.text == "" {
                    newItem.price = 0.0
                }else{
                newItem.price = Double(textField_2.text!)!
                }
                newItem.parentCategory = self.selectedCategory
                self.itemArray.append(newItem)
            
                self.saveItems()
        }
         //24.447707208232377, 54.39503754602803
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Expenes"
            textField = alertTextField
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.keyboardType = .decimalPad
            alertTextField.placeholder = "Item Price"
            textField_2 = alertTextField

        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //When user clicks the shop location
    
    @IBAction func getShopLocation(_ sender: UIBarButtonItem) {
        
        let shop_latitude = selectedCategory!.latitude
        let shop_longitude = selectedCategory!.longitude

        print("Latitude \(shop_latitude) and Longitude \(shop_longitude)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ShopMapViewController
        
        destinationVC.shop_latitude = selectedCategory!.latitude
        destinationVC.shop_longitude = selectedCategory!.longitude
        destinationVC.shop_name = selectedCategory!.name
    }
    func saveItems(){
        
        do{
            try context.save()
        }catch {
            print("Error saving context with \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
                
        do {
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}
