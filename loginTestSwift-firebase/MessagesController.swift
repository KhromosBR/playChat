//
//  ViewController.swift
//  loginTestSwift-firebase
//
//  Created by Khromos on 2017-04-26.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

 override func viewDidLoad() {
        super.viewDidLoad()
        //Create the button logout inside navigationViewController
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action:#selector(handleLogout))
    let rightBarImage = UIImage(named: "bubbles")
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarImage, style: .plain, target: self, action: #selector(handleNewMessage))
    
    navBarLogo()
    checkIfUserIsLoggedIn()
        
    }
    
    //Go to new message
    func handleNewMessage(){
        
        let newMessageController = NewMessageController()
        //Add navigation Controller to the viewController
        let navController = UINavigationController(rootViewController: newMessageController)
        //When oppen new viewController
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn(){
        
        //The user is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
//            fetchUserAndSetupNavBarTitle()
            navBarLogo()
        }
    }
    //Logo at navbarController
    func navBarLogo(){
        let appLogo = UIImage(named: "Play Party Round")
        let imageView = UIImageView(image: appLogo)
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
     
        self.navigationItem.titleView = imageView
    }
    
    func fetchUserAndSetupNavBarTitle(){
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        FIRDatabase.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
//                self.navigationItem.title = dictionary["name"] as? String
                //send the user to the other func to be used
                let user = User(dictionary: dictionary)
                
                self.setupNavbarWithUser(user)
            }
            
        }, withCancel: nil)

    }
    
    func setupNavbarWithUser(_ user: User){
        
//        let titleView = UIView()
//        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        titleView.backgroundColor = UIColor.blue
////        self.navigationItem.title = user.name
        let appLogo = UIImage(named: "Play Party Round")
        let imageview = UIImageView(image: appLogo)
        imageview.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        self.navigationItem.titleView = imageview
        
//        Add name to navbar
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        titleView.addSubview(containerView)
//        
//        let profileImageView = UIImageView()
//        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//        profileImageView.contentMode = .scaleAspectFill
//        profileImageView.layer.cornerRadius = 20
//        profileImageView.clipsToBounds = true
//        if let profileImageUrl = user.profileImageUrl {
//            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
//        }
//        
//        containerView.addSubview(profileImageView)
//        
//        //ios 9 constraint anchors
//        //need x,y,width,height anchors
//        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        let nameLabel = UILabel()
//        
//        containerView.addSubview(nameLabel)
//        nameLabel.text = user.name
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        //need x,y,width,height anchors
//        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
//        
//        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
//        
//        self.navigationItem.titleView = titleView
    }
    
    //Logout Button
    func handleLogout(){
        //If the user is already logged in the program automatically goes to the first page
        do {
            
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print(logoutError)
        }
        
        let loginController = LoginController()
        loginController.messagesController = self
        present(loginController, animated: true, completion: nil)
    }
}

