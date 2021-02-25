//
//  ContentView.swift
//  ToDoApp
//
//  Created by Mac  on 2/23/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    init() {
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        Home()
    }
}


