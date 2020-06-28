//
//  Todo.swift
//  Todo
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import Foundation
import RealmSwift

//
class Todo: Object {
    //
    @objc dynamic var id: Int = 0
    //
    @objc dynamic var title: String = ""
    //
    @objc dynamic var deadline: Date = Date()
    //
    @objc dynamic var isDone: Bool = false

    //
    override class func primaryKey() -> String? {
        return "id"
    }
}
