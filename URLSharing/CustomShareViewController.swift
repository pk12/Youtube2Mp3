//
//  ShareViewController.swift
//  URLSharing
//
//  Created by Panagiotis Kanellidis on 8/7/20.
//  Copyright © 2020 Panagiotis Kanellidis. All rights reserved.
//
 
import UIKit
import SwiftUI
import Social
import MobileCoreServices

class CustomShareViewController: UIViewController {

    private var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupNavBar()
        
        let child = UIHostingController(rootView: ContentView())
        addChild(child)
        self.view.addSubview(child.view)
        
        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let contentTypeURL = kUTTypeURL as String
        
        for attachment in extensionItem.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeURL) {
                attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil) { (results, error) in
                    let url = results as! URL?
                    self.urlString = url!.absoluteString
                }
            }
        }
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Youtube To Mp3"

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }
    
    @objc private func cancelAction () {
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "Action Cancelled"])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc private func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

}
