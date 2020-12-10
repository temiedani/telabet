//
//  ThirdViewController.swift
//  Practice#1
//
//  Created by Temesgen Daniel on 10/12/2020.
//

import UIKit

class ThirdViewController: UIViewController {
    var myString :String? = ""
    var myString2 :String? = ""
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdLabel.text = myString!
        fourthLabel.text = myString2!
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
