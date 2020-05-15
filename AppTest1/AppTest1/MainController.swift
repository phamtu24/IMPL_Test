//
//  ViewController.swift
//  AppTest1
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let passData = Notification.Name("passData")
}

class MainViewController: UIViewController, DetailToMain {

    @IBOutlet weak var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(observeData(notification:)), name: .passData, object: nil)
    }

    func passData(value: String) {
        mainLabel.text = value
    }
    
    @objc func observeData(notification: Notification) {
        mainLabel.text = notification.object as? String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.mainVC = self
        detailVC.delegate = self
        detailVC.completionHandler = { [unowned self] value in
            self.mainLabel.text = value
        }
    }
    
    func receiveData(_ value: String) {
        mainLabel.text = value
    }

}

