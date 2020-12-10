//
//  ViewController.swift
//  Expenses App with Core Data
//
//  Created by Temesgen Daniel on 01/12/2020.
//

import UIKit
import CoreData
import MapKit

class CategoryViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var categories = [Category]()
    var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let imagePicker = UIImagePickerController()
    var selectedShop: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCategories()
    }
    
    //MARK: TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for : indexPath) as! CategoryTableViewCell
        
        let category = categories[indexPath.row]
        
        let shopTotal = loadItems(category: category)
        
        cell.shopName.text = category.name
        cell.shopTotal.text = "Spent: \(shopTotal) AED"
        cell.shopImage.image = UIImage(data: category.profile!)
        
        cell.imageButtonAction = { [unowned self] in
            
            selectedShop = indexPath.row
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            //vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems"{
            
            let destinationVC = segue.destination as! ItemViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let category = categories[indexPath.row]
            categories.remove(at: indexPath.row)
            context.delete(category)

            do {
                try context.save()
            } catch {
                print("Error deleting category with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)  //includes updating UI so reloading is not necessary
        }
    }
    
    
    //MARK: Data Manipulation Methods
    
    func saveCategories(){
        
        do{
            try context.save()
        }catch {
            print("Error saving category with \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(category: Category) -> Double {
        
        let request = Item.fetchRequest() as NSFetchRequest<Item>
        
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", category.name!)
        request.predicate = predicate
        
        items = try! context.fetch(request)
        
        var totalAmount = 0.0
        for item in items {
            totalAmount += item.price
        }
        return totalAmount
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "locationVC") as! LocationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            categories[selectedShop!].profile = image.pngData()
            //                imageView.image = image
            //                noImageLabel.text = ""
            //                addImageButton.setTitle("Change receipt photo", for: UIControl.State.normal)
            saveCategories()
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
