//
//  Home.swift
//  ToDoApp
//
//  Created by Mac  on 2/23/21.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    // Fetching Data ....
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<ToDo>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0){
                
                HStack {
                    
                    Text("TODO")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.gray)
                
                // Empty View ....
                
                if results.isEmpty {
                    
                    Spacer()
                    
                    Text("Tidak Ada List !!!")
                        .font(.title)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                else {
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading,spacing: 20) {
                            
                            ForEach(results){task in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.light)
                                    
                                    Text(task.date ?? Date(),style: .date)
                                        .fontWeight(.semibold)
                                    
                                })
                                .foregroundColor(.white)
                                .contextMenu {
                                    
                                    Button(action: {homeData.EditItem(item: task)}, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Hapus")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            // Add Button ....
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
    }
}
