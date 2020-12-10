//
//  SecondViewController.swift
//  Practice#1
//
//  Created by Temesgen Daniel on 09/12/2020.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var myString :String?
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        secondLabel.text = myString!
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        myImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var secondLabel: UITextField!
    @IBAction func secondButton(_ sender: UIButton) {
        print("tapped")
        //dismiss(animated: true)
    }
    
}
