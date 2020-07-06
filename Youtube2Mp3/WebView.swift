//
//  WebView.swift
//  Youtube2Mp3
//
//  Created by Panagiotis Kanellidis on 5/7/20.
//  Copyright © 2020 Panagiotis Kanellidis. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    @State var wkWebView: WKWebView = WKWebView()
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some WKWebView {
        wkWebView.navigationDelegate = context.coordinator
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func loadHtmlString(string: String, srcUrl: String) {
        wkWebView.loadHTMLString(string, baseURL: URL(string: srcUrl))
    }
}
