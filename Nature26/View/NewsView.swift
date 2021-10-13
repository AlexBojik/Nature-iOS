
import WebKit
import SwiftUI

struct NewsView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        if appData.newsService.loading {
            ProgressView()
        }
        if !appData.newsService.news.isEmpty {
            VStack {
                Spacer()
                HTMLStringView(htmlContent: appData.newsService.news).padding()
                Spacer()
            }
        }
    }
}
