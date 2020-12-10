//
//  CategoryTableViewCell.swift
//  MyExpensesApp
//
//  Created by Temesgen Daniel on 07/12/2020.
//  Copyright © 2020 kodechamp. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet var shopName: UILabel!
    @IBOutlet var shopTotal: UILabel!
    @IBOutlet var shopImage: UIImageView!
    
    @IBOutlet weak var imageButton: UIButton!
    
    var imageButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func imageButtonTapped(_ sender: UIButton){
      // if the closure is defined (not nil)
      // then execute the code inside the imageButtonAction closure
      imageButtonAction?()
    }
    
    
}
