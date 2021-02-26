//
//  UsersTVC.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 25.02.2021.
//

import UIKit

class UsersTVC: UITableViewController, CustomCellDelegate {
   
    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"
    
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.fillingData(with: user)
        cell.delegate = self
        return cell
    }
    
    func cellButtonTapped(cell: UserCell) {
        //Вот оно!
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(identifier: "PostsSB") as? PostsTVC else { return }
        destination.indexUser = indexPath.row
 
        show(destination, sender: nil)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexParh = tableView.indexPathForSelectedRow else { return }
//        guard let postsVC = segue.destination as? PostsTVC else { return }
//        postsVC.indexUser = indexParh.row
//
//    }
    
    func fetchData() -> Void {
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            //Делаем не постаринке, а через автоматическую функции JSONDecoder
            //let user = User(id: <#T##Int?#>, name: <#T##String?#>, username: <#T##String?#>, email: <#T##String?#>, address: <#T##Address?#>, phone: <#T##String?#>, website: <#T##String?#>, company: <#T##Company?#>)
            //User хотим использовать как тип поэтому User.self - соотвественно массив []
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
                //print(self.users)
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
