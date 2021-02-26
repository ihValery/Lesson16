//
//  CommentsCell.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 26.02.2021.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var body: UILabel!
    
    func fillingComment(with comment: Comment) -> Void {
        name.text = comment.name
        email.text = comment.email
        body.text = comment.body
    }
}
