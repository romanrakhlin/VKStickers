//
//  SettingsTableViewController.swift
//  VKStickers
//
//  Created by Roman Rakhlin on 20.03.2020.
//  Copyright © 2020 Roman Rakhlin. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.jpg")) // задаем background
    }
    
    
    // Свитч, разрешить/запретить отправку уведомлений
    @IBAction func notificationsSwitch(_ sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")

        if (sender.isOn) {
            print("on")
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            print("Off")
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    
    
   // Конопка, оценить приложение
    @IBAction func rateAppButton(_ sender: Any) {
        rateApp()
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    // Кнопка, отправить письмо разработчику
    @IBAction func sendMainButton(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients(["exampleEmail@email.com"])
            composeVC.setSubject("Message Subject")
            composeVC.setMessageBody("Message content.", isHTML: false)
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Error")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Тэйбл Вью Дата Сорс

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // меняем цвет Header в каждом cell
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
}
