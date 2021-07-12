//
//  TaskManager.swift
//  MyReminder
//
//  Created by maihuutai on 01/07/2021.
//

import Foundation

struct Task: Codable {
    var title: String
}

class TaskManager: ObservableObject {
    static let TASK_KEY: String = "Task"
    static let DEFAULT_TASK: [Task] = [
        Task(title: "Do excercise"),
        Task(title: "Study online"),
        Task(title: "Eat breakfast")
    ]
    
    @Published var listTask: [Task] = loadData() {
        didSet {
            self.saveData()
        }
    }
    
    func addTask(title: String) {
        print("addTask method")
        let task = Task(title: title)
        listTask.append(task)
        print("Add task successfully")
    }
    
    func deleteTask(at offsets: IndexSet) {
        listTask.remove(atOffsets: offsets)
    }
    
    static func loadData() -> [Task] {
        let rawData = UserDefaults.standard.object(forKey: TaskManager.TASK_KEY)
        if let rawData = rawData as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Task].self, from: rawData)) ?? TaskManager.DEFAULT_TASK
        }
        return TaskManager.DEFAULT_TASK
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(listTask) {
            UserDefaults.standard.set(data, forKey: TaskManager.TASK_KEY)
        }
    }
}
