//
//  ChatChannelView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/20/23.
//

import SwiftUI

struct ChatChannelView: View {
    @State private var messageText = ""
    @State var chatHistories: [String] = ["Hello!"]
    @State var addNewPlan: Bool = false
    @State var seePlan: Bool = false
    @State var editProfile: Bool = false
    @State var name: String = ""

    var body: some View {
        VStack {
            Divider()
            HStack {
                }
            ScrollView {
                // messages
                ForEach (chatHistories, id: \.self) { message in
                    if message.contains("[coach]:") {
                        let newMessage = message.replacingOccurrences(of: "[coach]:", with: "")
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .font(.system(size: 18))
                                .foregroundColor(Color.white)
                                .background(Color(hex: 0xfcbf49))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        HStack {
                            Text(message)
                                .padding()
                                .font(.system(size: 18))
                                .foregroundColor(Color.white)
                                .background(.gray.opacity(0.5))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }.rotationEffect(.degrees(180))
                .background(Color.gray.opacity(0.2))
            
            HStack {
                TextField("Type something here.", text:$messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: "[coach]:" +  messageText)
                    }
                    Button {
                        sendMessage(message: "[coach]:" + messageText)
                    } label: {
                        Image (systemName: "paperplane.fill")
                    }
                    .foregroundColor(Color(hex: 0xF77F00, opacity: 1))
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
            }
        
        }

    }
    func sendMessage(message: String) {
        withAnimation {
            chatHistories.append(message)
            self.messageText = ""
        }
        // remove the auto-reply function
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            withAnimation {
//                chatHistories.append(getBotResponse(message: message))
//            }
//        }
    }
}


struct ChatChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChatChannelView()
    }
}
