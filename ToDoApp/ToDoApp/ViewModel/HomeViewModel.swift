//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by Mac  on 2/23/21.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject {
    
    @Published var content = ""
    @Published var date = Date()
    
    // For NewData Sheet ....
    @Published var isNewData = false
    
    //Checking And Updating Date ....
    
    // Storing Update Item ....
    @Published var updateItem: ToDo!
    
    let calender = Calendar.current
    
    func checkDate()->String {
        
        if calender.isDateInToday(date) {
            return "Hari Ini"
        }
        else if calender.isDateInTomorrow(date) {
            return "Besok"
        }
        else {
            return "Lain Hari"
        }
    }
    
    func updateDate(value: String) {
        
        if value == "Hari Ini"{date = Date()}
        else if value == "Besok"{
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }
        else {
            // do something ....
        }
    }
    
    func writeData(context : NSManagedObjectContext) {
        
        // Updating Item ....
        
        if updateItem != nil {
            
            // Means Update Old Data ....
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            
            // Removing updatingItem if successfull
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        
        let newTask = ToDo(context: context)
        newTask.date = date
        newTask.content = content
        
        //saving data ....
        
        do {
            
            try context.save()
            // Succes means closing view ...
            isNewData.toggle()
            content = ""
            date = Date()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: ToDo) {
        
        updateItem = item
        // Toggle the newDataView ....
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
}
