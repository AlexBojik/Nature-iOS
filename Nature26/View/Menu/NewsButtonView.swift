
import SwiftUI

struct NewsButtonView: View {
    @EnvironmentObject var appData: AppData
    
    @State var show = false
    
    var body: some View {
        HStack(content: {
            Button(Icons.newsIcon) { showNews() }
            .sheet(isPresented: $show) { NewsView() }
            .padding(.top)
            .foregroundColor(.red)
            
            Spacer()
        })
    }
    
    func showNews() {
        self.show.toggle()
        appData.newsService.updateNews(appData.objectWillChange.send)
    }
}
