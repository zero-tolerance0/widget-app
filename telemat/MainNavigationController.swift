//
//  MainNavigationController.swift
//  telemat
//
//  Created by didarmarat on 06.02.2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        if isLoggedIn() {
//            showTasksViewController()
//        } else {
//            perform(#selector(showRegViewController), with: nil, afterDelay: 1.0)
//            showRegViewController()
//        }
//        asd()
        navigateToMainVC()
    }
    
    func navigateToMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController (withIdentifier: "ViewController") as! ViewController
        pushViewController(vc, animated: false)
    }
    
    func asd(){
        if let vc = viewControllers.first as? ViewController {
            vc.checkIfAppLaunchedFromWidgetAndShowHideWebView()
        }
    }
    
//    fileprivate func isLoggedIn() -> Bool {
//        return UserDefaults.standard.isLoggedIn()
//    }
//
//    @objc func showRegViewController(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController (withIdentifier: "RegViewController") as! RegViewController
//        let nc = UINavigationController(rootViewController: vc)
//        nc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        present(nc, animated: true, completion: nil)
//    }
//
//    func showTasksViewController(){
////        guard let windowScene = (scene as? UIWindowScene) else { return }
////        if UserDefaults.standard.string(forKey: "token") != nil {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController (withIdentifier: "TasksViewController") as! TasksViewController
//        viewControllers = [vc]
////        }
////        guard let windowScene = (scene as? UIWindowScene) else { return }
////        if UserDefaults.standard.string(forKey: "token") != nil {
////            let storyboard = UIStoryboard(name: "Main", bundle: nil)
////            let vc = storyboard.instantiateViewController (withIdentifier: "FirstNav") as! FirstNav
////            window = UIWindow(windowScene: windowScene)
////            window?.rootViewController = vc
////            window?.makeKeyAndVisible()
////        }
//    }
//
//    func handleDeepLinkTaskDetails(taskId: String) {
//        if isLoggedIn() {
//            if let vc = viewControllers.first as? TasksViewController {
//                popToRootViewController(animated: false)
//                vc.proccedToTaskDetailsFromDeeplink(taskId)
//            }
//        } else {
//            perform(#selector(showRegViewController), with: nil, afterDelay: 1.0)
//            showRegViewController()
//        }
//    }
}
