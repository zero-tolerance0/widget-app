//
//  ViewController.swift
//  telemat
//
//  Created by didarmarat on 26.01.2022.
//

import UIKit
import WebKit
import WidgetKit
extension ViewController: WKUIDelegate, WKNavigationDelegate {
//func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//   //load cookie of current domain
//    webView.loadDiskCookies(for: url.host!){
//        decisionHandler(.allow)
//    }
//}
//
//public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//   //write cookie for current domain
//    webView.writeDiskCookies(for: url.host!){
//        decisionHandler(.allow)
//    }
//}
}

class ViewController: UIViewController, WKScriptMessageHandler{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var tutorialWebView: WKWebView!
    
    var urlString = "https://lk.telemat.su/"
    var tutorialUrlString = "https://telemat.su/startios.html"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupWebView()
        
//        asd()
    }
    
    func checkIfAppLaunchedFromWidgetAndShowHideWebView() {
        let appLaunchedFromWidget = UserDefaults.standard.getIsOpenedFromWidget()
        setupHiddenWebView(appLaunchedFromWidget)
    }
    
    func setupHiddenWebView(_ appLaunchedFromWidget: Bool){
        debugPrint("setupHiddenWebView called")
        if tutorialWebView != nil {
            debugPrint("tutorialWebView not nil")
            tutorialWebView.isHidden = appLaunchedFromWidget
        }
        getTMValues()
        UserDefaults.standard.setIsOpenedFromWidget(value: false)
    }
    
    func setupWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.configuration.userContentController.add(self, name: "transferLogin")
//        webView.scalesPageToFit = true

        
//        if let deviceId = UserDefaults.standard.getDeviceId() {
//            urlString+=deviceId
//        }
        let url = URL(string: urlString)!
        let urlReq = URLRequest(url: url)
        webView.load(urlReq)

        let tutorialUrl = URL(string: tutorialUrlString)!
        let tutorialUrlReq = URLRequest(url: tutorialUrl)
        tutorialWebView.load(tutorialUrlReq)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("Message received: \(message.name) with body: \(message.body)")
        if let deviceId = message.body as? Int {
            if deviceId == -1 {
                debugPrint("user logged out")
                saveDeviceId(nil)
            } else {
                debugPrint("user logged in")
                let stringDeviceId = String(deviceId)
                saveDeviceId(stringDeviceId)
                sendFcmTokenWithDeviceId(stringDeviceId)
                getTMValues()
            }
        }
    }
    
    func sendFcmTokenWithDeviceId(_ deviceId: String){
        let fcmToken = UserDefaults.standard.getFcmToken() ?? ""
        ApiService.shared.saveNotificationToken(deviceId, fcmToken, "iOS", "testWidgetId")
    }
    
    func saveDeviceId(_ deviceId: String?){
        UserDefaults.standard.setDeviceId(value: deviceId)
    }
    
    func getTMValues(){
//        2040077
        guard let deviceId = UserDefaults.standard.getDeviceId() else {
            print("user not authed")
            return
        }
        ApiService.shared.getTMValuesUsing(deviceId) { TMValues, err in
            if let _ = err {
                DispatchQueue.main.async {
                    debugPrint("error")
                    debugPrint(err?.localizedDescription)
                }
                return
            }
            DispatchQueue.main.async {
                debugPrint(777)
                debugPrint(TMValues?.formatValue)
//                guard let TMValues = try? JSONEncoder().encode(TMValues) else {return}
                let userDefaults = UserDefaults(suiteName: "group.ru.dreamteam.telemat")
                userDefaults?.setValue(TMValues?.formatValue, forKey: "formatValue")
                userDefaults?.setValue(TMValues?.deviceName, forKey: "deviceName")
                userDefaults?.setValue(TMValues?.paramName, forKey: "paramName")
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

