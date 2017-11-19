//
//  SolveViewController.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SolveViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView!
    private var timer: Timer?
    
    @IBAction func refreshButton(_ sender: Any) {
        self.loadPage()
    }
    
    let sitekey = "6LeoeSkTAAAAAA9rkZs5oS82l69OEYjKRZAiKdaF"
    let baseURL = "http://checkout.shopify.com"
    let imageURL = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController.add(self, name: "captchaReceived")
        
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.webView.navigationDelegate = self
        self.webView.scrollView.bounces = false
        self.webView.isMultipleTouchEnabled = true
        self.webView.contentMode = .scaleToFill
        self.webView.contentScaleFactor = 15.0
        self.webView.scrollView.isScrollEnabled = false
        self.webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        loadPage()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page has loaded")
        SVProgressHUD.dismiss()
    }
    
    func fetchForToken() {
        self.webView.evaluateJavaScript("document.getElementById('g-recaptcha-response').value;") { (any,error) -> Void in
            let response = any as! String
            if response != "" {
                let myAlert = UIAlertController(title: "Token Sent!", message: "Captcha Token has been sent.", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
                self.submitToken(token: response)
                return self.loadPage()
            }
            
        }
    }
    
    func loadPage() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        self.webView.loadHTMLString("<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\" />\r\n<head>\r\n<style>\r\nform {\r\n  text-align: center;\r\n}\r\nbody {\r\n  text-align: center;\r\n\r\n  \r\n}\r\n\r\nh1 {\r\n  text-align: center;\r\n}\r\nh3 {\r\n  text-align: center;\r\n}\r\ndiv-captcha {\r\n      text-align: center;\r\n}\r\n    .g-recaptcha {\r\n        display: inline-block;\r\n    }\r\n</style>\r\n\r\n<meta name=\"referrer\" content=\"never\"> <script type='text/javascript' src='https://www.google.com/recaptcha/api.js'></script><script>function sub() { window.webkit.messageHandlers.captchaReceived.postMessage(document.getElementById('g-recaptcha-response').value); }</script></head> <body bgcolor=\"#ffffff\"oncontextmenu=\"return false\"><div id=\"div-captcha\"><br><img width=\"50%\" src=\"\(imageURL)\"/><br><br><div style=\"opacity: 0.9\" class=\"g-recaptcha\" data-sitekey=\"\(sitekey)\" data-callback=\"sub\"></div></div><br>\r\n\r\n</body></html>", baseURL: URL(string: baseURL))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.fetchForToken()
    }
    
    func submitToken(token: String!) {
        // TODO
    }

    
}
