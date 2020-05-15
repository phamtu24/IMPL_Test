//
//  DetailViewController.swift
//  AppTest1
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit

protocol DetailToMain {
    func passData(value: String)
}

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detailTextfield: UITextField?
    var delegate: DetailToMain!
    var completionHandler: ((String) -> Void)?
    var mainVC: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func passDataBack(_ sender: Any) {
        guard let valueToPass = detailTextfield?.text else { return }
        // Pass data using delegation
//        delegate.passData(value: valueToPass)
        
        // Pass data using notification center
//        NotificationCenter.default.post(name: .passData, object: valueToPass, userInfo: nil)
        
        // Pass data using closure
//        completionHandler?(valueToPass)
        
        // Pass data using property
        mainVC.receiveData(valueToPass)
        
        navigationController?.popViewController(animated: true)
    }
    
}
