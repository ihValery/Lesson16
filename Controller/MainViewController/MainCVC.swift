//
//  mainCVC.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 25.02.2021.
//

import UIKit

//Подпишем перечисление к стрингу, дабы задать красивое отображение на кнопках ))
//CaseIterable позволяет из перечисления сделать массив, для дальнейшей работы
enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case seeAllUser = "See all user"
    
}

//Для регистрации в коде, но мы используем сторибоард и там дали индетификатор
//private let reuseIdentifier = "Cell"

class MainCVC: UICollectionViewController {

    //Массив наших Actions из всех case
    private let userActions = UserActions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Чтобы сохранить выбор между презентациями
        //self.clearsSelectionOnViewWillAppear = false

        //Так как задали идентификатор в стоиборде, регистрация нам не нужна
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    
    /*
    //Задает количество секций, но у нас будет 1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCV", for: indexPath) as! UserActionCell
        //Доступ к исходному значению члена перечисления, через свойство rawValue (достучимся до Stringового значения)
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    //Каждый раз когда мы нажимаем
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
            case .downloadImage:
                performSegue(withIdentifier: "goToImage", sender: self)
            case .seeAllUser:
                performSegue(withIdentifier: "goToUser", sender: self)
        }
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToImage" {
            let imageVC = segue.destination as! ImageVC
            imageVC.fetchImage()
        }
        if segue.identifier == "goToUser" {
            let usersVC = segue.destination as! UsersTVC
            usersVC.fetchData()
        }
    }
}

extension MainCVC: UICollectionViewDelegateFlowLayout {
    
    //В этом методе полность настраивается внешний вид ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 60, height: 80)
    }
}

