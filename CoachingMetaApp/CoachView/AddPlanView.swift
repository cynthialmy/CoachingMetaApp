//
//  AddPlanView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/21/23.
//

import SwiftUI

struct AddPlanView: View {
    @State var taskName = ""
    @State var sportName = ""
    @State var heartRate = ""
    @State var calories = ""
    @State var addNewTask: Bool = false
    
    @State var planList: [Task] = [
//        Task(task_id: "1", task_name: "This is the first task", update_date: "", client_id: "", isDone: 0, description: ""),
//        Task(task_id: "2", task_name: "This is the second task", update_date: "", client_id: "", isDone: 0, description: ""),
//        Task(task_id: "3", task_name: "This is the third task", update_date: "", client_id: "", isDone: 0, description: "")
    ]
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addPlanViewModel = PostNewPlanViewModel()
    var body: some View {
        
        VStack{
            List {
                Text("New Task").font(.largeTitle).bold()
                
                //                HStack{
                //                    Text("Sport Name")
                //                    TextField("Enter sport name", text: $sportName)
                //    //                Picker("Sport Name", selection: $sportName) {
                //    //                    Text("HIIT").tag(1).foregroundColor(Color(hex:0xf77f00))
                //    //                    Text("Dance").tag(2).foregroundColor(Color(hex:0xf77f00))
                //    //                    Text("Cycling").tag(3).foregroundColor(Color(hex:0xf77f00))
                //    //                    Text("Swimming").tag(4).foregroundColor(Color(hex:0xf77f00))
                //    //                }
                //                    Spacer()
                //                }
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
                    Text("Date").font(.system(size: 20)).bold()
                })
                //                HStack {
                //                    Text("Duration (minutes)")
                //    //                Spacer().frame(width: 20)
                //                    TextField("Enter valid number", text: $heartRate)
                //
                //                }
            }.frame(height:109).listStyle(PlainListStyle())
            
            VStack(alignment: .leading){
                HStack{
                    Text("     Tasks").bold()
                    Button {
                        addNewTask = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(hex:0xf77f00))
                    }
                    .sheet(isPresented: $addNewTask) {
                        AddView(task: "", taskDetails: "") { enteredTask, details in
                            let newTaskId = UUID().uuidString
                            planList.append(Task(task_id: newTaskId, task_name: enteredTask, update_date: "", client_id: "", isDone: 0, description: details))
                            print(planList.count)
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                List {
                    ForEach(planList) { task in
                        ListRowView(task: task,viewModel: SampleFitnessDataViewModel())
                            .onTapGesture {
                                updateItem(task: task)
                            }
                    }.onDelete(perform: deleteItem)
                }.listStyle(PlainListStyle())
            }.font(.system(size: 20)).padding(.vertical)
            Button{
                //TODO: add actions of adding plans
                presentationMode.wrappedValue.dismiss()
                let newPlan = Plan(client_id: userID, update_date: Date().toString(), tasks: planList)
                addPlanViewModel.addNewPlan(uid: userID, plan: newPlan)
            } label:{
                //                Text("Submit")
                Text("Submit")
                    .font(.system(size: 20)).bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color(hex: 0xfcbf49))
                    .cornerRadius(15.0)
                
            }
        }.padding()
    }
    func deleteItem(indexSet: IndexSet) {
        planList.remove(atOffsets: indexSet)
    }
    func updateItem(task: Task) {
        if let index = planList.firstIndex(where: { $0.task_id == task.task_id }) {
            planList[index] = Task(task_id: task.task_id, task_name: task.task_name, update_date: task.update_date, client_id: task.client_id, isDone: task.isDone, description: task.description)
        }
    }
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView()
    }
}
