//
//  TaskView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/10/23.
//

import SwiftUI

struct TaskView: View {
    @State private var update : Bool = false
    var body: some View {
        let details: [String] = [
            "10 minutes of Jump Jack",
            "5 minutes of abdominal curl"
            ]
        VStack {
            Text("My Tasks")
                .font(.largeTitle)
                .bold()
            VStack(alignment: .center) {
                
                ListView(details: details).frame(height:25).font(.system(size: 23))
                
                Button {
                    update = true
                } label : {
                    Text("Update").font(.system(size: 23))
                }.padding(.horizontal, 10)
                    .sheet(isPresented: $update, content: {
                        FitnessDataView()
                    }
                    )
            }
            
        }
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
