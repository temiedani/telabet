//
//  GameOverViewController.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scorelabel: UILabel!
    
    var passedscore = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificatio(_:)), name: Notification.Name("text"), object: nil)
        // Do any additional setup after loading the view.
        scorevalue.text = passedscore
    }
    @objc func didGetNotificatio(_ notification:Notification){
        let text = notification.object as!String?
        scorevalue.text = text
    }
    @IBOutlet weak var scorevalue: UILabel!
    
    @IBAction func playTapped(_ sender: Any) {
        
        let secondview = storyboard?.instantiateViewController(withIdentifier: "game") as! ViewController
        
        secondview.modalPresentationStyle = .fullScreen
        present(secondview,animated:true)
    }
    
    
}
