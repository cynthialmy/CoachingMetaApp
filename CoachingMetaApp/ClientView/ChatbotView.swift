//
//  ContentView.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 3/7/23.
//

import SwiftUI
//TODO: add a button to switch between chatbot and coach..
struct ChatbotView: View {
//    @Binding var showMenu: Bool = false
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to Chatbot! Feel free to ask me anything you are curious about."]
    @State var addNewPlan: Bool = false
    @State var seePlan: Bool = false
    @State var editProfile: Bool = false
    var body: some View {
        VStack {
            Divider()
            HStack {
//                Text("Coaching Meta")
//                    .bold()
//                Button {
//                    seePlan = true
//                } label: {
//                    Image (systemName: "folder")
//                }
//                .font(.system(size: 26))
//                .padding(.horizontal, 10)
//                .sheet(isPresented: $seePlan, content: {
//                    TaskView()
//                })
//                .buttonStyle(BorderlessButtonStyle())
                }
            ScrollView {
                // messages
                ForEach (messages, id: \.self) { message in
                    if message.contains("[user]:") {
                        let newMessage = message.replacingOccurrences(of: "[user]:", with: "")
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
                        sendMessage(message: "[user]:" +  messageText)
                    }
                    Button {
                        sendMessage(message: "[user]:" + messageText)
                    } label: {
                        Image (systemName: "paperplane.fill")
                    }
                    .foregroundColor(Color(hex: 0xF77F00, opacity: 1))
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
//                Divider()
//                Button {
//                    self.addNewPlan = true
//                } label: {
//                    Image (systemName: "plus.app")
//                }
//                .font(.system(size: 26))
//                .padding(.horizontal, 10)
//                .sheet(isPresented: $addNewPlan, content: {
//                    PlanView()
//                })

//                }

            }
        
        }

    }
    func sendMessage(message: String) {
        withAnimation {
            messages.append(message)
            self.messageText = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                messages.append(getBotResponse(message: message))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}
