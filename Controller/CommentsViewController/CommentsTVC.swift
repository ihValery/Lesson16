//
//  CommentsTVC.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 26.02.2021.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    private let jsonUrl = "https://jsonplaceholder.typicode.com/comments?postId="
    
    private var comments: [Comment] = []
    
    var postId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataComment()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comCell", for: indexPath) as! CommentsCell
        let comment = comments[indexPath.row]
        cell.fillingComment(with: comment)

        return cell
    }
    
    func fetchDataComment() -> Void {
        let urlComment = jsonUrl + String(postId + 1)
        guard let url = URL(string: urlComment) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
