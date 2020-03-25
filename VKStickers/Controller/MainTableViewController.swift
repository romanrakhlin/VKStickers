//
//  MainTableViewController.swift
//  VKStickers
//
//  Created by Roman Rakhlin on 17.03.2020.
//  Copyright © 2020 Roman Rakhlin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MainTableViewController: UITableViewController {
    
    var packTitle = [String]()
    var packDescription = [String]()
    var packImage = [String]()
    
    var sortedData: String?
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var isAscending = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.jpg")) // задаем background
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("Packs/Title").observe(.childAdded) { (snapshot) in
            
            // берем название
            let title = snapshot.value as? String
            
            if let actualTitle = title {
                self.packTitle.append(actualTitle)
                
                self.tableView.reloadData()
            }
        }
            
        databaseHandle = ref?.child("Packs/Description").observe(.childAdded) { (snapshot) in
            
            // берем описание
            let description = snapshot.value as? String
            
            if let actualDescription = description {
                self.packDescription.append(actualDescription)
            }
        }
        
        databaseHandle = ref?.child("Packs/Image").observe(.childAdded) { (snapshot) in
            
            // берем картинку
            let image = snapshot.value as? String
            
            if let actualImage = image {
                self.packImage.append(actualImage)
            }
        }
    }
    
    // MARK: - Для TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packTitle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackCell", for: indexPath) as! PackCell
        cell.packImage = packImage[indexPath.row]
        cell.showImage()
        cell.titleLable.text = packTitle[indexPath.row]
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.packTitle = packTitle[(tableView.indexPathForSelectedRow?.row)!]
            destination.packDescription = packDescription[(tableView.indexPathForSelectedRow?.row)!]
            
            // выстаскиваем картинку из ссылки
            guard let url = URL(string: packImage[(tableView.indexPathForSelectedRow?.row)!]) else { return }
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        destination.imageView.image = image
                    }
                }
            }.resume()
        }
    }
}
