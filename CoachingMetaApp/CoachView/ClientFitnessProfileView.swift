//
//  ClientFitnessProfileView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 4/21/23.
//

import SwiftUI

var selected: Int = 7

struct ClientFitnessProfileView: View {
    @StateObject private var clientListViewModel = ClientListViewModel(coachUID: userID)
    @StateObject private var fitnessDataViewModel = FitnessDataViewModel()
    var client: Client
    var clientName: String = "Sicilia Li"
    var clientUID: String = "client1" // Add clientUID to the view
    
    // TODO: make it come from previous page
    var joinDate: String = "2023-04-02"
    var averageWorkOutTime: [Int] = [60, 75, 15, 90, 50, 35, 86]
    var displayTags: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" ]
    init(client: Client, coachUID: String, clientName: String) {
             self.client = client
             self.clientName = clientName
//             _viewModel = StateObject(wrappedValue: ClientListViewModel(coachUID: coachUID))
//             _clientName = State(initialValue: client.client_name)

             let startDate = "2023-04-21"
             let endDate = "2023-04-28"

         }

    
    // TODO: make it come from previous page
   
    // TODO: make it rotate...
    @State var currentTab: String = "History" // Today or History
//    @State var historyExerciseList: [[String: String]] = [["update_date": "04272023"], ["update_date": "04262023"]]
    
    var body: some View {
        VStack (spacing: 20){
            Spacer()
            HStack{
                Image(systemName: "person.circle")
                    .font(.system(size: 70))
                    .foregroundColor(Color.gray)
                VStack (alignment: .leading) {
                    Text(clientName)
                        .bold()
                        .font(.system(size: 35))
                        .foregroundColor(Color(hex:0x003049))
                }
                        
                Spacer()
            }
            
            VStack (spacing: 30){
                HStack {
                    Image(systemName: "timer")
                    Text("Exercise Time (min)").bold()
                    Spacer()
                }
                
                HStack(alignment: .bottom, spacing: 10) {
                    ForEach(Array(averageWorkOutTime.enumerated()), id: \.1){ (id, element) in
                        BarCell(workoutTime: element, time: displayTags[id], index: id)
                            .onTapGesture {
                                selected = id
                            }
                    }
                }
                
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
            .shadow(color: Color.white.opacity(0.5), radius: 5, x:-8, y: -8)
            
            // Add this Text view to display the duration from the fetched workout data
//            Text("Duration: \((clientListViewModel.workoutData["duration"] as? Int) ?? 0) minutes")
//                .font(.title2)
//                .foregroundColor(Color(hex: 0x003049))
            
            HStack{
                
                Button(action: {
                    currentTab = "History"
                }) {
                    Text("History")
                        .foregroundColor(currentTab == "History" ? Color.white : .gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(currentTab == "History" ? Color(hex: 0xf77f00): Color.clear)
                        .cornerRadius(10)
                }
            }
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
            .shadow(color: Color.white.opacity(0.5), radius: 5, x:-8, y: -8)
            
            if (currentTab == "Today") {
                // TODO: change these numbers to var
                VStack (spacing: 20){
                    HStack (spacing: 20){
                        HealthDataDisplayPanel(image: "map", data: 4, count: "KM")
                        HealthDataDisplayPanel(image: "shoeprints.fill", data: 7580, count: "Steps")
                    }
                    HStack(spacing: 20){
                        HealthDataDisplayPanel(image: "figure.run", data: 654, count: "KCal")
                        HealthDataDisplayPanel(image: "timer", data: 86, count: "Min")
                    }
                    
                }.frame(height: 320)
                
            } else {
                ZStack{
                    VStack {
                        List{
                            ForEach(fitnessDataViewModel.exerciseList, id:\.self) { exercise in
                                NavigationLink(destination: ClientFinishedPlanView(clientName: clientName, date: exercise["update_date"]?.toDate()?.toString() ?? Date().toString())){
                                    Text("\((exercise["update_date"]?.toDate()?.toString())!)")
                                }
                                
                            }

                        }
                        .onAppear{
                            fitnessDataViewModel.getHistory(client_id: clientUID)
//                            print("View count \(fitnessDataViewModel.exerciseList.count)")
//                            historyExerciseList = fitnessDataViewModel.exerciseList
//                            print("View count \(historyExerciseList.count)")
                        }
                        .listStyle(PlainListStyle())
                        
                    }.frame(height: 320)
                    
                    NavigationLink{
                        AddPlanView()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: 64, height: 64)
                    .background(Color(hex: 0xfcbf49))
                    .cornerRadius(32)
                    .shadow(color: .gray, radius: 4, x: 0, y: 4)
                    .offset(x:130, y:130)
                }
            }
            
            
        }.padding()
    }
    
    @ViewBuilder
    func HealthDataDisplayPanel(image: String, data: Int, count: String) -> some View {
        VStack (spacing: 8){
            Image(systemName: image)
            
            
            Text(String(data)).font(.title).bold()
            
            Text(count)
        }
        .foregroundColor(Color(hex: 0x003049))
        .frame(width: 110, height: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15).foregroundColor(Color(hex: 0xeae2b7, opacity: 0.2))
        )
        .shadow(color: Color(hex: 0xeae2b7, opacity: 0.5), radius: 5, x: 8, y: 8)
        .shadow(color: Color.white.opacity(0.5), radius: 5, x:-8, y: -8)
        
    }
}


struct BarCell: View {
    let workoutTime: Int
    let time: String
    let index: Int
    
    var body: some View {
        VStack{
            Text(String(workoutTime)).foregroundColor(Color.gray)
            //            Button (action: {
            //                if (selected == index) {
            //                    selected = 7
            //                } else {
            //                    selected = index
            //                }
            //            }) {
            //                RoundedRectangle(cornerRadius: 10)
            //                    .fill(selected == index ?
            //                          Color(hex:0xf77f00)
            //                          :Color(hex:0x003049).opacity(0.8))
            //                    .frame(height: CGFloat(workoutTime))
            //            }
            //            .disabled(selected != 7 && selected != index)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex:0x003049).opacity(0.8))
                .frame(height: CGFloat(workoutTime))
            
            Text(time).foregroundColor(Color(hex:0x003049))
        }
    }
}



struct FloatingActionButton: View {
    let icon: String
    //    let action: () -> Void
    
    var body: some View {
        Button{} label: {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(width: 64, height: 64)
        .background(Color(hex: 0xfcbf49))
        .cornerRadius(32)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

struct ClientFitnessProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClientFitnessProfileView(client: Client(client_id: "client1", client_name: "John Doe"), coachUID: "coach1", clientName: "")
        }
    }
}
