//
//  DetailViewController.swift
//  VKStickers
//
//  Created by Roman Rakhlin on 17.03.2020.
//  Copyright © 2020 Roman Rakhlin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var packTitle: String?
    var packDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.isEditable = false // запрещаем изменение textview

        titleLabel.text = packTitle
        descriptionTextView.text = packDescription
        
        // закругляем углы у картинки
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    // кнопка Поделиться
    @IBAction func shareButton(_ sender: Any) {
        let message = "Узнавай о новых бесплатных стикерах ВК"
        if let link = NSURL(string: "http://yoururl.com")
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
