//
//  ContentView.swift
//  MyReminder
//
//  Created by maihuutai on 01/07/2021.
//

import SwiftUI

struct List_Task_View: View {
    @State var isPresented: Bool = false
    @StateObject var taskManager = TaskManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(taskManager.listTask, id: \.title) {
                        Text($0.title)
                    }
                    .onDelete(perform: taskManager.deleteTask)
                }
            }
            .navigationBarTitle("List to do")
            .padding()
            .navigationBarItems(
                trailing:
                    Button(action: { isPresented = true }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .sheet(isPresented: $isPresented, content: {
                        Add_Task_View(taskManager: taskManager, isPresented: $isPresented)
                    })
            )
        }
        ZStack {
            
        }
    }
}

struct Add_Task_View: View {
    var taskManager: TaskManager
    @Binding var isPresented: Bool
    @State private var taskToAdd: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Type your task")
                        .bold()
                        .font(.system(size: 30))
                ) {
                    TextField("Title", text: $taskToAdd)
                }
            }
            .navigationBarTitle(Text("Add task"), displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.addTask()
                    }) {
                        Text("Add")
                            .bold()
                    }
            )
        }
    }
    
    private func addTask() {
        taskManager.addTask(title: taskToAdd)
        isPresented.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        List_Task_View()
        Add_Task_View(taskManager: TaskManager(), isPresented: .constant(true))
    }
}
