//
//  ViewController.swift
//  Todo
//
//  Created by 藤井陽介 on 2020/06/28.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit

//
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //
    @IBOutlet var tableView: UITableView!

    var todoArray: [Todo] = []
    //
    let segueIdentifier: String = "toEdit"
    //
    let realmHelper = RealmHelper()

    //
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        tableView.delegate = self
        //
        tableView.dataSource = self
    }

    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //
        todoArray = realmHelper.fetchAllData()
        //
        tableView.reloadData()
    }

    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == segueIdentifier {
            //
            let viewController: EditViewController = segue.destination as! EditViewController
            //
            viewController.todo = sender as? Todo
        }
    }

    //
    func convertToString(_ date: Date) -> String {
        //
        let dateFormatter = DateFormatter()
        //
        dateFormatter.dateFormat = "yyyy/MM/dd"
        //
        return dateFormatter.string(from: date)
    }

    @IBAction func tapAddButton() {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }

    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return todoArray.count
    }

    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //
        let todo: Todo = todoArray[indexPath.row]
        //
        cell.textLabel?.text = todo.title
        //
        cell.detailTextLabel?.text = convertToString(todo.deadline)
        //
        cell.accessoryType = todo.isDone ? .checkmark : .none

        return cell
    }

    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let todo: Todo = todoArray[indexPath.row]
        //
        performSegue(withIdentifier: segueIdentifier, sender: todo)
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

