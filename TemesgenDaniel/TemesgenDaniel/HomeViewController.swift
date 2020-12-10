//
//  HomeViewController.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func playTapped(_ sender: Any) {
        let secondview = storyboard?.instantiateViewController(withIdentifier: "game") as! ViewController
        secondview.modalPresentationStyle = .fullScreen
        present(secondview,animated:true)
        
        
    }
    
    @IBAction func tutorialTapped(_ sender: Any) {
        
        let secondview = storyboard?.instantiateViewController(withIdentifier: "tutorial") as! TutorialViewController
        secondview.modalPresentationStyle = .fullScreen
        present(secondview,animated:true)
        
        
    }
    

}
