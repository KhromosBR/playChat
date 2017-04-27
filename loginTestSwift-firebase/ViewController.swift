//
//  ViewController.swift
//  loginTestSwift-firebase
//
//  Created by Khromos on 2017-04-26.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Create the button logout inside navigationViewController
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }
    
    func handleLogout(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
        
    }

    

}

