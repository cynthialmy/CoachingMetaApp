//
//  TaskView.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/10/23.
//

import SwiftUI

struct TaskView: View {
    @State var taskName: String = "Exercise 1"
    @State private var update : Bool = false
    var body: some View {
        VStack (alignment: .leading){
            Text(taskName)
                .font(.largeTitle)
                .bold()
            VStack(alignment: .center) {
                
                ListView()

            }
            Spacer()
        }.padding()
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
