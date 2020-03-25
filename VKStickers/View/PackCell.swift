//
//  PackCell.swift
//  VKStickers
//
//  Created by Roman Rakhlin on 18.03.2020.
//  Copyright © 2020 Roman Rakhlin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PackCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageViewView: UIImageView!
    
    var packImage: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // делаем из view конфетку
        mainView.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: mainView.bounds)
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowPath = shadowPath2.cgPath
        
        // закругляем углы у картинки
        imageViewView.layer.masksToBounds = false
        imageViewView.layer.cornerRadius = imageViewView.frame.height/2
        imageViewView.clipsToBounds = true
    }
    
    // для передачи картинки
    func showImage() {
        guard let url = URL(string: packImage!) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageViewView.image = image
                }
            }
        }.resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
