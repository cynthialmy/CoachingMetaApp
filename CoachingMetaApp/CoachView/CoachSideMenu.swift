//
//  CoachSideMenu.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/27/23.
//

import SwiftUI


struct CoachSideMenu: View {
    @Binding var showMenu: Bool
    @Binding var userRole: String
    @StateObject private var viewModel = CoachInfoViewModel(coach_id: userID)
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height:50)
//                    .clipShape(Circle())
                Text(viewModel.coach_name)
                .font(.title2.bold())
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 23) {
                        // use of view builders
                        NavigationLink {
                            CoachInfoView().foregroundColor(Color(hex:0x003049)).navigationTitle("Profile")
                        } label: {
                            HStack(spacing: 14) {
                                Image(systemName: "doc.text")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                                
                                Text("Profile")
                            }
                            
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
    
//                        TabButton(title: "Profile", image: "doc.text")
//                        TabButton(title: "My Coach", image: "person.2.wave.2")
//                        TabButton(title: "My plans", image: "list.bullet.clipboard")
                        TabButton(title: "Help", image: "questionmark.bubble")
                        TabButton(title: "Purchases", image:
                        "cart")
                        TabButton(title: "Settings", image: "wrench.adjustable")
                    }
//                    .padding()
                    .padding(.leading)
                    .padding(.top, 35)
                }
                VStack(alignment: .leading, spacing: 10) {
//                    TabButton(title: "Log Out", image: "figure.walk.departure")
                    NavigationLink {
                        SignInView(onDismiss: {}).navigationBarHidden(true)
                    } label : {
                        HStack(spacing: 14) {
                            Image(systemName: "figure.walk.departure")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22, height: 22)
                            
                            Text("Log Out")
                        }
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text("COACHING META")
                        .bold()
                }
                
            }
            .padding(.horizontal)
            .padding(.leading)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 120)
        .frame(maxHeight: .infinity)
        .background(
            Color(hex: 0xF77F00, opacity: 0.8)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .foregroundColor(Color(hex: 0x003049))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder // implement tab buttons
    func TabButton(title: String, image: String) -> some View {
        Button {
            
        } label : {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct CoachSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        CoachBaseView()
    }
}
