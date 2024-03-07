//
//  ContentView.swift
//  TimeLineAnimation
//
//  Created by Naufal Adli on 05/03/24.
//

import SwiftUI

struct TdModel: Identifiable{
    var id = UUID()
    var title : String
    var isComplete: Bool
}

struct ContentView: View {
    @State var items: [TdModel] = [
    TdModel(title: "learn swiftui", isComplete: false),
    TdModel(title: "swiftui animation", isComplete: false),
    TdModel(title: "swiftdata", isComplete: false)

    ]
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                ForEach(items.indices,id: \.self){ item in
                    HStack{
                        Image(systemName: items[item].isComplete ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(items.allSatisfy({$0.isComplete}) ? .green : .primary)
                        
                        Text(items[item].title)
                            .strikethrough(items[item].isComplete)
                            .animation(.none,value: items[item].isComplete)
                        
                        Spacer()
                    }.font(.title2)
                        .overlay(alignment: .topLeading){
                            Rectangle()
                                .frame(width: 1,height: items[item].isComplete ? 68 : 0)
                                .offset(y: 24)
                                .padding(.leading,12)
                        }
                        .frame(height: 90)
                        .onTapGesture {
                            withAnimation{
                                items[item].isComplete.toggle()
                            }
                        }
                }
                
                HStack{
                    Image(systemName: items.allSatisfy({$0.isComplete}) ? "checkmark.circle.fill" : "circle")
                    Text("Finish")
                    Spacer()
                }
                .foregroundColor(items.allSatisfy({$0.isComplete}) ? .green : .gray)
                .font(.title2)
                .frame(height: 58,alignment: .bottom)
                .onTapGesture{
                   toggleItems()
                }
            }
            .padding()
        }
    }
    func toggleItems(){
        let alltrue = items.allSatisfy({$0.isComplete})
        updateItemsSequentially(maketrue: !alltrue, revers: alltrue)
    }
    
    func updateItemsSequentially(maketrue: Bool, revers: Bool){
        let delayStep = 0.5
        let indies = revers ? Array(items.indices.reversed()) :  Array(items.indices)
        for (offset, item) in indies.enumerated(){
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                withAnimation{
                    items[item].isComplete.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
