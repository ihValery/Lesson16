//
//  ViewController.swift
//  Lesson16
//
//  Created by Валерий Игнатьев on 25.02.2021.
//

import UIKit

class ImageVC: UIViewController {
    
    private let imageUrl = "https://images.performgroup.com/di/library/NBA_Global_CMS_image_storage/f9/f7/lebron-james-enters-his-16th-season-with-questions-left-answered_hebm8r5ni6ie1l7qa9cl0ogij.png"
    
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Для запуска индикатора загрузки
        activityIndicator.startAnimating()
        //при true - activityIndicator будет скрываться после остановки
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() -> Void {
        guard let url = URL(string: imageUrl) else { return }
        
        let sesion = URLSession.shared //синглтон
        
        //Будет сделан запрос и вернеться три объекта { замыкание и не забываем использовать self. }
        sesion.dataTask(with: url) { (data, respons, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let respons = respons {
                print(respons)
            }
            //Извлекаю опционал из data, и пытаюсь извлечь картинку из data
            if let data = data, let image = UIImage(data: data) {
                //Выход из фонового режима в основной поток, и все это делать в асинхронном режиме
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.downloadImage.image = image
                }
            }
        //Находиться в подвешенном состоянии, и не выполниться пока не получит команду .resume()
        }.resume()
    }
}

