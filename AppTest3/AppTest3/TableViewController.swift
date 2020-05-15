//
//  ViewController.swift
//  AppTest3
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UpdateInfo {
    
    
    
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getListUsers()
    }
    
    func getListUsers() {
        users = handleJSON()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func passData(name: String, email: String, phone: String, id: Int) {
        users?[id] = User(createdAt: nil, email: email, name: name, phone: phone)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lblName.text = users?[indexPath.row].name ?? "updating"
        cell.lblEmail.text = users?[indexPath.row].email ?? "updating"
        cell.lblPhone.text = users?[indexPath.row].phone ?? "updating"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let row = tableView.indexPathForSelectedRow?.row else { return }
        let detailVC = segue.destination as! DetailViewController
        detailVC.name = users?[row].name
        detailVC.email = users?[row].email
        detailVC.phone = users?[row].phone
        detailVC.id = row
        detailVC.delegate = self
    }
}

