//
//  OnboardingViewController.swift
//  VKStickers
//
//  Created by Roman Rakhlin on 19.03.2020.
//  Copyright © 2020 Roman Rakhlin. All rights reserved.
//

import UIKit
import OnboardKit

class OnboardingViewController: UIViewController {
    
    var userData = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let onboardingVC = OnboardViewController(pageItems: onboardingPages, completion: {
            print("onboarding complete")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
        onboardingVC.modalPresentationStyle = .overFullScreen
        onboardingVC.presentFrom(self, animated: true)
    }
    
    // данные всех страниц Onboarding
    lazy var onboardingPages: [OnboardPage] = {
        let pageOne = OnboardPage(title: "Здравствуйте!",
                                  imageName: "Onboarding1",
                              description: "Данное приложение поможет вам с поиском бесплатных стикеров ВК.")

        let pageTwo = OnboardPage(title: "Все очень просто!!",
                              imageName: "Onboarding2",
                              description: "Сначала найдите интересующий вас Стикер Пак.")

        let pageThree = OnboardPage(title: "Все очень просто!!",
                                imageName: "Onboarding3",
                                description: "Затем посмотрите как его добавить.")

        let pageFour = OnboardPage(title: "Уведомления",
                               imageName: "Onboarding4",
                               description: "Разрешите получение уведомлений, чтобы получать уведомления о новых бесплатных стикерах.",
                               advanceButtonTitle: "Позже",
                               actionButtonTitle: "Разрешить уведомления",
                               
                               action: { [weak self] completion in
                                self?.showAlert(completion)
        })

        let pageFive = OnboardPage(title: "Все готово",
                               imageName: "Onboarding5",
                               description: "Желаем вам приятного использования нашего приложения.",
                               advanceButtonTitle: "Готово")

        return [pageOne, pageTwo, pageThree, pageFour, pageFive]
  }()
    

    private func showAlert(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        
        let alert = UIAlertController(title: "Разрешить уведомления?",
                                  message: "Бесплатные Стикеры ВК хочет отправлять вам уведомления",
                                  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Подтвердить", style: .default) { _ in
            completion(true, nil)
        })
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel) { _ in
            completion(false, nil)
        })
        presentedViewController?.present(alert, animated: true)
    }
}
