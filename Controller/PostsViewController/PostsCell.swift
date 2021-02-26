//
//  AboutCell.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 26.02.2021.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    func fillingPost(with post: Post) -> Void {
        postId.text = "N \(post.id ?? 000)"
        title.text = "Title: \(post.title ?? "Error")"
        body.text = post.body
    }
}
