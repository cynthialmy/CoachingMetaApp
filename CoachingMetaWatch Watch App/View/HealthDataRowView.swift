//
//  HealthDataRowView.swift
//  watchApp Watch App
//
//  Created by Sicilia Li on 4/24/23.
//

import SwiftUI

struct HealthDataRowView: View {
    @State var ImageName: String
    @State var TextString: String
    @State var Number: Int
    @State var Description: String
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .firstTextBaseline){
                Image(systemName: ImageName)
                    .font(.system(size: 26))
//                Spacer()
                Text(TextString).font(.system(size: 16))
            }
            Text(String(Number)).font(.system(size: 46))
            Text(Description).font(.system(size: 13)).foregroundColor(yellow)
        }.padding()
    }
}

struct HealthDataRowView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDataRowView(ImageName: "heart.circle", TextString: "Heart Rate", Number: 6339, Description: "BPM")
    }
}
