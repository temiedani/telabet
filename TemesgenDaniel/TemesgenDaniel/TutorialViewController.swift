//
//  TutorialViewController.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var tutorial4: UILabel!
    var text1 = "#Single tap changes the skull form."
    var text2 = "#Double tap changes the eyes shape"
    var text3 = "#Swipe right changes mouth shape ."
    var text4 = "#Swipe left changes face color ."
    var text5 = "#Swipe down opens and closes eye."

    @IBOutlet weak var tutrial4: UILabel!
    @IBOutlet weak var tutrial5: UILabel!
    @IBOutlet weak var tutorial3: UILabel!
    @IBOutlet weak var tutorial2: UILabel!
    @IBOutlet weak var tutorial1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorial1.text = text1
        tutorial2.text = text2
        tutorial3.text = text3
        tutorial4.text = text4
        tutrial5.text = text5        // Do any additional setup after loading the view.
    }
    


    
    
    @IBAction func backtapped(_ sender: Any) {
        let secondview = storyboard?.instantiateViewController(withIdentifier: "game") as! ViewController
        
        secondview.modalPresentationStyle = .fullScreen
        present(secondview,animated:true)
        
    }
    

}
