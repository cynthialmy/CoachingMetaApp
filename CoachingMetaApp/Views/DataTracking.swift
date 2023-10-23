//
//  DataTrackingswift
//  CoachingMetaApp
//
//  Created by Guanming Chen on 3/30/23.
// UNUSED

import SwiftUI

struct DataTracking: View {
    @State private var heartRate = "125"
    @State private var calories = "5000"
    @State private var duration = "500"
    @State private var sleeping_hours = "8"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let eating_details: [String] = [
            "One Apple",
            "100g Rice",
            "500g Beef"
            ]
        VStack {
            Text("")
                .font(.system(size:30))
            HStack (alignment: .center){
                Text("     Health Data Tracking")
                    .font(.system(size:27))
                    .bold()

                Image(systemName: "heart.fill")
                    .font(.system(size:26))
                    .foregroundColor(Color.blue)
                Spacer().frame(width: 20)
            }
            List {
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
                    Text("Start Date")
                })
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
                    Text("End Date")
                })
                HStack {
                    Text("Total Working out time (minutes)")
                    Spacer().frame(width: 20)
                    TextField("", text: $duration)
                }
                HStack {
                    Text("Total Calories (cal)")
                    Spacer().frame(width: 20)
                    TextField("", text: $calories)
                }
                HStack {
                    Text("Avg Heart rate (bpm)")
                    Spacer().frame(width: 20)
                    TextField("", text: $heartRate)
                }
                HStack {
                    Text("Avg Sleeping Per Day (hours)")
                    Spacer().frame(width: 20)
                    TextField("", text: $sleeping_hours)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Eating Habits")
                        Spacer()
                    }
//                    ListView(details: eating_details).frame(height:25)
                }
            }
            Button {
                presentationMode.wrappedValue.dismiss()
            } label : {
                Text("Back").font(.system(size: 23))
            }.padding()
        }
       
    }
}

struct DataTracking_Previews: PreviewProvider {
    static var previews: some View {
        DataTracking()
    }
}
