
import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(
            """
            <html lang="ru">
            <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
            <style>
                :root {
                    color-scheme: light dark;
                }
            </style>
            <title>User Guide</title>
            </head>
            <body>
            \(htmlContent)
            </body>
            </html>
            """, baseURL: nil)
    }
}
