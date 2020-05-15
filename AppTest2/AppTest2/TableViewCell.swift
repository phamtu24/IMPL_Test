//
//  TableViewCell.swift
//  AppTest2
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
