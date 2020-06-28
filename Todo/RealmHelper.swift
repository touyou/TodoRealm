//
//  RealmHelper.swift
//  Todo
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import Foundation
import RealmSwift

//
class RealmHelper {
    //
    let realm = try! Realm()

    //
    func fetchAllData() -> [Todo] {
        //
        let todos = realm.objects(Todo.self).sorted(byKeyPath: "deadline")
        return todos.map { $0 }
    }

    //
    func getNewId() -> Int {
        //
        let todos = realm.objects(Todo.self)
        //
        if let lastId = todos.last?.id {
            return lastId + 1
        }
        //
        return 0
    }

    //
    func saveData(title: String, deadline: Date, isDone: Bool) {
        //
        let todo = Todo()
        //
        todo.id = getNewId()
        //
        todo.title = title
        //
        todo.deadline = deadline
        //
        todo.isDone = isDone
        //
        try! realm.write {
            realm.add(todo)
        }
    }

    //
    func updateData(todo: Todo, title: String? = nil, deadline: Date? = nil, isDone: Bool? = nil) {
        //
        try! realm.write {
            //
            if let title = title {
                todo.title = title
            }
            //
            if let deadline = deadline {
                todo.deadline = deadline
            }
            //
            if let isDone = isDone {
                todo.isDone = isDone
            }
        }
    }
}
