//
//  ProfileView.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Image("profile")
                .resizable()
                .frame(width: 120, height: 120)                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
                .shadow(radius: 3)
                
            Text("Oky Nazla Ghifari")
                .font(.title)
            HStack {
                Image(systemName: "envelope")
                Text("nazlaghifari@gmail.com")
                Spacer()
            }
            Divider()
            Spacer()
        }.padding()
        
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
