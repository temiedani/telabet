//
//  ViewController.swift
//  Practice#1
//
//  Created by Temesgen Daniel on 09/12/2020.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    @IBAction func fistButton(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "secondVC") as? SecondViewController
        else{
            print("lol")
            return
        }
        
        // present with embedded navigation bar
        navigationController?.pushViewController(vc, animated: true)
        
        
        //presnt modally
        //vc.modalPresentationStyle = .popover
        //present(vc, animated: true)
        
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoThird"{
            
            let destinationVC = segue.destination as! ThirdViewController
            destinationVC.myString = firstLabel.text
            destinationVC.myString2 = "Daniel"
        }else if(segue.identifier == "gotoSecond"){
            
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myString = firstLabel.text
        }
        
    }
    
    
}

