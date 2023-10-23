//
//  AddView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/8/23.


import SwiftUI

struct AddView: View {
    @State var task: String = ""
    @State var taskDetails: String = ""
    let completion: ((String, String) -> Void)
    @State var taskList: [String] = []
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack (spacing: 30){
                TextField("Task title", text: $task)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
//                TextField("Details", text: $taskDetails)
//                    .padding(.horizontal)
//                    .frame(height: 250)
//                    .background(.gray.opacity(0.2))
//                    .cornerRadius(10)
            TextEditor(text: $taskDetails)
                .frame(height: 250)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                            .background(Color.gray.opacity(0.2))
                    )
                    
                Button {
                    completion(task, taskDetails)
                    presentationMode.wrappedValue.dismiss()
                } label:{
                    Text("submit")
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(orange)
                        .cornerRadius(10)
                }
            Spacer()
            }.padding(10)
           
        
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
//        let planList : [String] = ["123"]
        NavigationView {
            AddView() { result1, result2 in
            }
        }
    }
}
