//
//  UserTVC.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 25.02.2021.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func cellButtonTapped(cell: UserCell)
}

class UserCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    func fillingData(with user: User) -> Void {
        name.text = user.name
        username.text = user.username
        email.text = user.email
        phone.text = user.phone
        website.text = user.website
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.cellButtonTapped(cell: self)
    }
    
}
