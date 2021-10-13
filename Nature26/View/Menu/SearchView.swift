
import SwiftUI

struct SearchView: View {
    @EnvironmentObject var appData: AppData
    @State var search: String = ""
    @State var show = false
    
    func onCommit() {
        show = false
        appData.featureService.search(search, appData.objectWillChange.send)
    }
        
    var body: some View {
        if !show {
            HStack {
                Button(Icons.searchIcon) { show = true }
                    .padding(.top, 60)
                    .foregroundColor(.blue)
                Spacer()
            }
        } else {
            SearchFieldView(search: $search, onCommit: onCommit)
        }
    }
}
