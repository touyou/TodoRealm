//
//  EditViewController.swift
//  Todo
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit

//
class EditViewController: UIViewController {

    //
    @IBOutlet var titleTextField: UITextField!
    //
    @IBOutlet var deadlineDatePicker: UIDatePicker!
    //
    @IBOutlet var doneSwitch: UISwitch!

    //
    var todo: Todo?
    //
    let realmHelper = RealmHelper()

    //
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        if let todo = todo {
            //
            titleTextField.text = todo.title
            //
            deadlineDatePicker.date = todo.deadline
            //
            doneSwitch.isOn = todo.isDone
        }
        //
        titleTextField.becomeFirstResponder()
    }

    //
    @IBAction func tapSaveButton() {
        //
        let alertController: UIAlertController
        //
        if let title = titleTextField.text, !title.isEmpty {
            //
            alertController = UIAlertController(title: "保存する", message: "保存しますか？", preferredStyle: .alert)
            //
            alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            //
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                //
                if let todo = self.todo {
                    //
                    self.realmHelper.updateData(
                        todo: todo, title: title,
                        deadline: self.deadlineDatePicker.date,
                        isDone: self.doneSwitch.isOn)
                } else {
                    //
                    self.realmHelper.saveData(
                        title: title,
                        deadline: self.deadlineDatePicker.date,
                        isDone: self.doneSwitch.isOn)
                }
                //
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            //
            alertController = UIAlertController(title: "タイトルが空欄です", message: "タイトルを入力してください。", preferredStyle: .alert)
            //
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        //
        present(alertController, animated: true, completion: nil)
    }
}
