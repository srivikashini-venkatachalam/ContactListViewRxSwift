//
//  ContactTableViewCell.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactProfile: UIImageView!
    @IBOutlet weak var displayData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}

}
