//
//  DetailViewController.swift
//  AppTest3
//
//  Created by Pham Tu on 5/15/20.
//  Copyright © 2020 Pham Tu. All rights reserved.
//

import UIKit

protocol UpdateInfo {
    func passData(name: String, email: String, phone: String, id: Int)
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegEx = "([0-9]{10})"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        return self.count >= 4 && self.count <= 20
    }
}




class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    
    var name: String?
    var email: String?
    var phone: String?
    var id: Int?
    var oldData: [User]?
    
    var delegate: UpdateInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = name
        txtEmail.text = email
        txtPhone.text = phone
        oldData = handleJSON()
    }
    
    func validate() -> Bool {
        name = txtName.text
        email = txtEmail.text
        phone = txtPhone.text
        guard let isValidName = name?.isValidName() else { return false }
        guard let isValidEmail = email?.isValidEmail() else { return false }
        guard let isValidPhone = phone?.isValidPhone() else { return false }
        nameError.isHidden = isValidName
        emailError.isHidden = isValidEmail
        phoneError.isHidden = isValidPhone
        return isValidName && isValidEmail && isValidPhone
    }
    
    @IBAction func onPressUpdate(_ sender: Any) {
        if validate() {
            delegate?.passData(name: name!, email: email!, phone: phone!, id: id!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onPressReset(_ sender: Any) {
        txtName.text = oldData?[id!].name
        txtEmail.text = oldData?[id!].email
        txtPhone.text = oldData?[id!].phone
    }
}
