//
//  FitnessDataView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/8/23.
//

import SwiftUI

struct FitnessDataView: View {
    @ObservedObject var viewModel = FitnessDataViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("")
                .font(.system(size:30))
            List {
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
                    Text("Date")
                })
                HStack {
                    Text("Duration (minutes)")
                    Spacer().frame(width: 20)
                    TextField("Enter valid number", text: $viewModel.duration)
                }
                HStack {
                    Text("Calories")
                    Spacer().frame(width: 20)
                    TextField("Enter valid number", text: $viewModel.calories)
                }
                HStack {
                    Text("Heart rate")
                    Spacer().frame(width: 20)
                    TextField("Enter valid number", text: $viewModel.heartRate)
                }
                
                HStack {
                    Text("Oxgyen Saturation")
                    Spacer().frame(width: 20)
                    TextField("Enter valid number", text: $viewModel.oxygenSaturation)
                }
                VStack(alignment: .leading) {
                    Text("Tasks")
                    // ListView(viewModel: SampleFitnessDataViewModel())
                    VStack {
                        List {
                            ForEach(viewModel.tasks) { task in
                                ListRowView(task: task, viewModel: viewModel)
                                    .id(task.task_id)
                                    .frame(height: 20)
                            }
                        }.frame(height: 200).listStyle(PlainListStyle()) // prevent scroll view..
                    }.onAppear {
                        viewModel.getTasks()
                    }
                }
                VStack (alignment: .leading){
                    Text("Notes")
                    TextEditor(text: $viewModel.note)
                        .padding()
                        .frame(height: 50)
                    //                    TextField("", text: $note).lineLimit(20).padding()
                }
            }.listStyle(PlainListStyle()).font(.system(size: 19))
            Button {
                presentationMode.wrappedValue.dismiss()
                viewModel.createWorkout()
                viewModel.updateTasks(tasks: viewModel.tasks)
            } label : {
                Text("update").font(.system(size: 23))
            }.padding()
        }
        .onAppear {
            viewModel.getTasks()
        }
        .ignoresSafeArea(.keyboard)
        .foregroundColor(Color(hex: 0x003049))
        
    }
}

struct FitnessDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FitnessDataView(viewModel: SampleFitnessDataViewModel())
        }
    }
}
