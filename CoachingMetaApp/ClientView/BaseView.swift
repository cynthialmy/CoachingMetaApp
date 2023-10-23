//
//  BaseView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/12/23.
//

import SwiftUI

var errorText = ""
var currentClientInfo = ClientInfo(client_name:"",
                                   birthday: "",
                                   gender: "",
                                   height: "",
                                   weight: "",
                                   exercisePreference: 1)

struct BaseView: View {
    @State var showMenu: Bool = false
    @State var userRole: String = "client" // client or coach
    @State var currentTab: String = "Messages"
    @State var isCoachOnline: Bool = false // sign of whether coach is online
    
    var systemService = SystemService()
    func getClientInfoAndNavigate() {
        systemService.getClientInfo(client_id: userID ) { result in
            switch result {
            case .success(let client):
                if client.client_name != "" {
                    currentClientInfo = client
                }
            case .failure(let error):
                errorText = error.localizedDescription
            }
        }
    }
    // hiding native
    init() {
        self.getClientInfoAndNavigate()
        UITabBar.appearance().isHidden = true
    }
    
    // offset for showing menu
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 120
        
        NavigationView{
            
            HStack(spacing: 0) {
                SideMenu(showMenu: $showMenu, userRole: $userRole)
               
                VStack {
                    // header of app
                    HStack (alignment: .center, spacing: 90){
                        Button {
                            
                            withAnimation{
                                showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                        }
                        if isCoachOnline {
                            Text("Your coach").font(.system(size: 20))
                                .bold()
                        }
                        else {
                            Text("CHATBOT").font(.system(size: 20))
                                .bold()
                        }
                        if (currentTab == "Today") {
                            NavigationLink {
                                FitnessDataView()
                                .foregroundColor(Color(hex:0x003049))
                                .navigationTitle("Add new Workout")
                            } label: {
                                Image(systemName: "doc.badge.plus")
                                    .font(.system(size: 25))
                            }
                        } else {
                            Button("") {
                            }.frame(width: 30, height: 30)
                        }
                    }.foregroundColor(Color(hex: 0xF77F00, opacity: 1))
                     
                    
                    TabView(selection: $currentTab) {
                        ChatbotView().tag("Messages")
                        HealthView().tag("Today")
                    }
                    
                    VStack(spacing: 0) {
            
                        HStack (spacing: 130) {
                        TabButton(image: "ellipsis.message", action: "Messages")
                            TabButton(image: "figure.cooldown", action: "Today")
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
            .navigationBarHidden(true)
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




struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
