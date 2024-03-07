//
//  CustomDropMenu.swift
//  TimeLineAnimation
//
//  Created by Naufal Adli on 06/03/24.
//

import SwiftUI

struct DataModel{
    let iconName: String
    var title: String
    var destination: AnyView
}



struct CustomDropMenu: View {
    let listOne: [DataModel] = [
        DataModel(iconName: "text.bubble.fill", title: "Broadcast Lists", destination: AnyView(Text("hehe"))),
        DataModel(iconName: "star.fill", title: "Broadcast Lists View", destination: AnyView(Text("hehe1"))),
        DataModel(iconName: "link", title: "Started Api", destination: AnyView(Text("hehe2"))),
        DataModel(iconName: "key.fill", title: "Started View", destination: AnyView(Text("hehe3")))
    ]
    
    @State var showList = false
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Image(systemName: "message.badge.waveform")
                        .frame(width: 30)
                    
                    Text("Messages")
                        .font(.title2)
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(showList ? 90 : 0))
                }
                .bold()
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 53)
                .background(.purple, in: RoundedRectangle(cornerRadius: 15))
                .onTapGesture {
                    withAnimation{
                        showList.toggle()
                    }
                }
                .zIndex(1)
                
                ForEach(listOne.indices,id: \.self){ item in
                    HStack{
                        Image(systemName: listOne[item].iconName)
                            .frame(width: 30)
                        
                        Text(listOne[item].title)
                        
                        Spacer()
                        
                        Image(systemName: "arrow-right")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.purple.opacity(showList ? 1 : (1 - Double(item) * 0.3)), in: RoundedRectangle(cornerRadius: 15))
                    .offset(y: showList ? CGFloat(item * 58) : CGFloat(item * 8))
                    .scaleEffect(showList ? 1 : (1 - Double(item) * 0.04))
                    .onTapGesture {
                        withAnimation{
                            showList.toggle()
                        }
                    }
                    .zIndex(CGFloat(item * -1))
                }
                .offset(y: showList ? 58 : 0)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    CustomDropMenu()
}
