//
//  CoachBaseView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/20/23.
//

import SwiftUI

struct CoachBaseView: View {
    @State var showMenu: Bool = false
    @State var userRole: String = "coach" // client or coach
    @State var currentTab: String = "Messages" // Messages Contacts
    @State var isCoachOnline: Bool = false // sign of whether coach is online
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // offset for showing menu
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 120
        
        NavigationView{
            
            HStack(spacing: 0) {
                CoachSideMenu(showMenu: $showMenu, userRole: $userRole)
               
                VStack {
                    // header of app
                    HStack (alignment: .center, spacing: 110){
                        Button {
                            withAnimation{
                                showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                        }
                        Text("Clients  ").font(.system(size: 20))
                            .bold()
                        
                            Button("") {
                            }.frame(width: 30, height: 30)
                        
                    }.foregroundColor(Color(hex: 0xF77F00, opacity: 1))
                     
                    
                    TabView(selection: $currentTab) {
                        if let uid = BaseService().getUID() {
                            ClientListView(coachUID: uid)
                                .listStyle(PlainListStyle())
                                .tag("Messages")
                        } else {
                            // Handle the case when the UID is nil (e.g., user not authenticated)
                            Text("User not authenticated")
                        }
                    }
                    
                    VStack(spacing: 0) {
            
                        HStack (spacing: 130) {
                        TabButton(image: "ellipsis.message", action: "Messages")
//                            TabButton(image: "person.2.square.stack", action: "Contacts")
                        }.foregroundColor(Color(hex: 0xF77F00, opacity: 1)).padding([.top], 15)
                    }
                    
                }
                .frame(width: getRect().width)
                .overlay(
                    Rectangle()
                        .fill(
                            Color.primary
                                .opacity(Double((offset/sideBarWidth) / 6))
                            
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            withAnimation{
                                showMenu.toggle()
                            }
                        }
                )
                
            }
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset)
            
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(true)
        }

        .accentColor(Color(hex: 0xf77f00))
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu) { newValue in
            if showMenu && offset == 0 {
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideBarWidth {
                // close menu
                offset = 0
                lastStoredOffset = 0
            }
            
        }
    }
    
    @ViewBuilder
    func TabButton(image: String, action: String) -> some View {
        Button{
            // action
            withAnimation {
                currentTab = action
            }
            
        } label: {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height:25)
        }
    }

}



struct CoachBaseView_Previews: PreviewProvider {
    static var previews: some View {
        CoachBaseView()
    }
}
