//
//  ViewController.swift
//  AppTest2
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {
    
    var users: [User] = []
    var limit: Int = 10
    var page: Int = 1
    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading == true {
                    self.indicator.startAnimating()
                } else {
                    self.indicator.stopAnimating()
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getListUser(page: page, limit: limit)
        setUpRefreshControl()
    }
    
    func setUpRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData () {
        page = 1
        getListUser(page: 1, limit: 10)
        
    }
    
    func getListUser(page: Int = 1, limit: Int = 10) {
        isLoading = true
        let urlString = "https://5eba40143f971400169923ef.mockapi.io/person?page=\(page)&limit=\(limit)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                guard users.count > 0 else {
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                    }
                    return
                }
                self.users = page == 1 ? users : self.users + users // delete all users when refreshing
                self.page += 1
                self.isLoading = false
                
            } catch let err {
                print(err)
            }
            
            }.resume()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == users.count-1 && !isLoading {
            getListUser(page: page, limit: limit)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lblName.text = users[indexPath.row].name
        cell.lblEmail.text = users[indexPath.row].email
        if let url = URL(string: users[indexPath.row].avatar ?? "") {
            cell.ivAvatar.sd_setImage(with: url, completed: nil)
        }
        return cell
    }
}

