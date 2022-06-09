//
//  ViewControllerSearch.swift
//  FunZone
//
//  Created by Xavier on 6/2/22.
//

import UIKit
import WebKit

class ViewControllerSearch: UIViewController {

    var prefSearchEngineIsGoogle = true
    @IBAction func buttonSwitchPSEDidTouchUpInside(_ sender: Any) {
        buttonSwitchPSEDidTouchUpInside_SwitchPSE()
    }
    @IBOutlet weak var buttonSwitchPSE: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadWebView()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewControllerSearch {
    func buttonSwitchPSEDidTouchUpInside_SwitchPSE() {
        if !prefSearchEngineIsGoogle {
            buttonSwitchPSE.setImage(UIImage(systemName: "network.badge.shield.half.filled"), for: .normal)
            prefSearchEngineIsGoogle = true
            loadWebView()
        } else {
            buttonSwitchPSE.setImage(UIImage(systemName: "network"), for: .normal)
            prefSearchEngineIsGoogle = false
            loadWebView()
        }
    }
    func loadWebView() {
        if prefSearchEngineIsGoogle {
            let webKitView = WKWebView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - 180))
            let myURL = URL(string: "https://www.google.com")!
            webKitView.load(URLRequest(url: myURL))
            webKitView.tag = 1
            view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
            view.addSubview(webKitView)
//            view.backgroundColor=UIColorFromRGB(0x209624)
            
        } else {
            //customize webKitView size and postion: width = screen width, heigh = screen height - 180 for header and tab barcontroller heighter
            let webKitView = WKWebView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - 180))
            let myURL = URL(string: "https://www.duckduckgo.com")!
            webKitView.load(URLRequest(url: myURL))
            webKitView.tag = 0
            view.backgroundColor = UIColor(red: 248/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
            view.addSubview(webKitView)
            
        }
    }
//    //set userDefault preferred SE
//    func setPrefSE_Predefined() { //init set up while not user pref is found
//        let userDefault = UserDefaults.standard
//        let prefSE = userDefault.string(forKey: "preferredSearchEngineIsGoogle")
//        if prefSE! == nil {
//            userDefault.set(false, forKey: "preferredSearchEngineIsGoogle")
//            buttonSwitchPSE.setImage(UIImage(systemName: "network"), for: .normal)
//        }
//    }
//    func setPrefSE() { //toggle switch update logic
//        let userDefault = UserDefaults.standard
//        let prefSE = userDefault.bool(forKey: "preferredSearchEngineIsGoogle")
//        if !prefSE {
//            userDefault.set(true, forKey: "preferredSearchEngineIsGoogle")
//            buttonSwitchPSE.setImage(UIImage(systemName: "network.badge.shield.half.filled"), for: .normal)
//        } else {
//            userDefault.set("D", forKey: "preferredSearchEngine")
//            buttonSwitchPSE.setImage(UIImage(systemName: "network"), for: .normal)
//        }
//    }
//    //get userDefault preferred SE
//    func getPrefSE() -> String {
//        let userDefault = UserDefaults.standard
//        userDefault.set("G", forKey: "preferredSearchEngine")
//        return ""
//    }
//    //load search engine homepage after view finished loading
//    func viewDidLoad_LoadSearchEngineHomePage() {
//        let webKitView = WKWebView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - 180))
//        let myURL = URL(string: "https://www.google.com")!
//        webKitView.load(URLRequest(url: myURL))
//        view.addSubview(webKitView)
//    }
//    //load DuckDuckGo homepage after view finishes loading
//    func viewDidLoad_LoadDDGHomePage() {
//        //customize webKitView size and postion: width = screen width, heigh = screen height - 180 for header and tab barcontroller heighter
//        let webKitView = WKWebView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - 180))
//        let myURL = URL(string: "https://www.duckduckgo.com")!
//        webKitView.load(URLRequest(url: myURL))
//        view.addSubview(webKitView)
//    }
}
