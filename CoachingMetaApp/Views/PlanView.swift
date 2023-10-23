////
////  PlanView.swift
////  CoachingMetaApp
////
////  Created by Sicilia Li on 3/8/23.
//// UNUSED
//
//import SwiftUI
//
//struct PlanView: View {
//    @State private var sportName = 0
//    @State private var heartRate = ""
//    @State private var calories = ""
//    @State var addNewTask: Bool = false
//    @State var details: [String] = [
//    "10 minutes of Jump Jack",
//    "5 minutes of abdominal curl"
//    ]
//    var body: some View {
//        VStack {
//            Text("")
//                .font(.system(size:30))
//            HStack {
//                Text("Edit your daily fitness plan")
//                    .font(.system(size:27))
//                    .bold()
//
//                Image(systemName: "figure.run")
//                    .font(.system(size:26))
//                    .foregroundColor(Color.blue)
//                Spacer().frame(width: 20)
//            }
//            List {
//                Picker("Sport Name", selection: $sportName) {
//                    Text("HIIT").tag(1)
//                    Text("Dance").tag(2)
//                    Text("Cycling").tag(3)
//                    Text("Swimming").tag(4)
//                }
//                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
//                    Text("Date")
//                })
//                HStack {
//                    Text("Duration (minutes)")
//                    Spacer().frame(width: 20)
//                    TextField("Enter valid number", text: $heartRate)
//                        .lineLimit(5)
//                }
//                VStack (alignment: .leading){
//                    
//                    HStack {
//                        Text("Plans")
//                        Spacer()
//                        Button {
//                            addNewTask = true
//                        } label: {
//                            Image(systemName: "plus.circle")
//                        }
//                        .sheet(isPresented: $addNewTask) {
////                            let inittask = ""
//                            AddView(task: "") { enteredTask, details in
//                                details.append(enteredTask)
//                            }
////                            details.append(inittask)
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                        
//                        
//                        Button {
//                            details.popLast()
//                        } label: {
//                        Image(systemName: "minus.circle")
//                        }.buttonStyle(PlainButtonStyle())
//                        
//                    }
//                    ListView().frame(height:25)
//                }
//                
////                HStack {
////                    Text("Calories")
////                    Spacer().frame(width: 40)
////                    TextField("Enter valid number, e.g: 100", text: $calories)
////                }
////                HStack {
////                    Text("Heart Rate")
////                    Spacer().frame(width: 40)
////                    TextField("Enter number, e.g: 100", text: $heartRate)
////                        .lineLimit(5)
////                }
////                VStack (alignment: .leading) {
//                    
////                    Text("Plans")
//                   
////                    TextField("Anything you want to share with your coach?", text: $details, axis: .vertical)
////                        .lineLimit(5, reservesSpace: true)
//
////                }
//            }
//            
//           
//            Button {
//                // todo: submit
//            }label: {
//                Text("Submit Plan")
//                .font(.system(size:23))
//            }
//        }
//    }
//}
//
//struct Previews_PlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanView()
//    }
//}
