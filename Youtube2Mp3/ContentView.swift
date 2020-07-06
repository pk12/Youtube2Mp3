//
//  ContentView.swift
//  Youtube2Mp3
//
//  Created by Panagiotis Kanellidis on 4/7/20.
//  Copyright © 2020 Panagiotis Kanellidis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var link: String = ""
    @State var webView: WebView = WebView()
    
    var body: some View {
        VStack(alignment: .center, spacing: 50.0) {
            Text("Enter Youtube URL")
                .font(.title)
            TextField("URL", text: $link)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.webView.loadHtmlString(string: self.generateHtml(), srcUrl: self.generateSource())
            }) {
                Text("Generate")
            }.disabled(self.link.isEmpty)
            self.webView
            Spacer()
        }.padding(.all)
    }
    
    func generateSource() -> String {
        let result = self.link.split(separator: "=")
        return "https://ytmp3.mobi/button-api/#\(result[1])|mp3|#1abc9c|#fff"
    }
    
    func generateHtml() -> String {
        return """
        <iframe style="width:100vw;height:200px;border:0;overflow:hidden;" src="\(self.generateSource())" scrolling="no" style="border:none"></iframe>
        """
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
