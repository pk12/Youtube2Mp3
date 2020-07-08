//
//  Coordinator.swift
//  Youtube2Mp3
//
//  Created by Panagiotis Kanellidis on 5/7/20.
//  Copyright © 2020 Panagiotis Kanellidis. All rights reserved.
//

import Foundation
import WebKit

class Coordinator : NSObject, WKNavigationDelegate {
    var parent: WebView
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    
    init(_ webView: WebView) {
        self.parent = webView
    }

    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let host = navigationAction.request.url?.host {
            if host.contains("ymcdn.website") {
                let task = URLSession.shared.downloadTask(with: navigationAction.request.url!) {
                    urlOrNil, responseOrNil, errorOrNil in
                    
                    guard let fileURL = urlOrNil else { return }
                    do {
                        let newURL = fileURL.deletingLastPathComponent()
                            .appendingPathComponent((responseOrNil?.suggestedFilename)!)
                            .deletingPathExtension()
                            .appendingPathExtension("mp3")
                        
                        try FileManager.default.copyItem(at: fileURL, to: newURL)
                        let activityViewController = UIActivityViewController(activityItems: [newURL], applicationActivities: nil)
                        
                        self.toggleSpinner(hide: true)
                        
                        DispatchQueue.main.async {
                            //Kinda hacky
                            let application = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as! UIApplication
                            
                            application.windows.first?.rootViewController?                          .present(activityViewController, animated: true, completion: nil)
                        }

                    }
                    catch {
                        print(error)
                    }
                }
                
                task.resume()
                toggleSpinner(hide: false)
                decisionHandler(.cancel)
                return

            }
        }
        
        decisionHandler(.allow)

        
    }
    
    func toggleSpinner(hide: Bool) {
        DispatchQueue.main.async {
            //Kinda hacky
            let application = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as! UIApplication

            if (hide) {
                application.windows.first?.rootViewController?
                .dismiss(animated: false, completion: nil)
            }
            else {
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.medium
                loadingIndicator.startAnimating();

                self.alert.view.addSubview(loadingIndicator)
                
                application.windows.first?.rootViewController?
                    .present(self.alert, animated: true, completion: nil)
            }
        }
    }
}
