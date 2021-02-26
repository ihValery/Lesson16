//
//  AboutTableViewController.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 26.02.2021.
//

import UIKit

class PostsTVC: UITableViewController {
    
    private let jsonUrl = "https://jsonplaceholder.typicode.com/posts?userId="
    
    private var posts: [Post] = []
    
    var indexUser: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataPost()
    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexParh = tableView.indexPathForSelectedRow else { return }
        guard let commentVC = segue.destination as? CommentsTVC else { return }
        commentVC.postId = indexParh.row
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! PostsCell
        let post = posts[indexPath.row]
        cell.fillingPost(with: post)

        return cell
    }
    
    
    func fetchDataPost() -> Void {
        let urlPost = jsonUrl + String(indexUser + 1)
        guard let url = URL(string: urlPost) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                print(self.posts)
            } catch let error {
                print(error)
            }
            //Выход из фонового режима в основной поток, и все это делать в асинхронном режиме
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
