//
//  ViewController.swift
//  profileViewController
//
//  Created by Ricardo Duarte Sampaio on 2017-05-07.
//  Copyright © 2017 Ricardo Duarte Sampaio. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navbar items
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action:#selector(handleLogout))
        
        //views declaration
        view.backgroundColor = UIColor.gray
        view.addSubview(profileImageView)
        view.addSubview(userDataContainer)
        
        //constraint declaration
        profileImageContraits()
        userDataContainerContraits()
    }
    
    //Button Back at navbarController
    func handleBack(){
        dismiss(animated: true, completion: nil)
    }
    
    //LOG OUT Button
    func handleLogout(){
        //If the user is already logged in the program automatically goes to the first page
        do {
            
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print(logoutError)
        }
        
        let loginController = LoginController()
        //Add navigation Controller to the viewController
        let logController = UINavigationController(rootViewController: loginController)
        //When oppen new viewController
        present(logController, animated: true, completion: nil)
       
    }
    
    func checkIfUserIsLoggedIn(){
        
        //The user is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            //        fetchUserAndSetupNavBarTitle()
            //            navBarLogo()
        }
    }
    
    //Create itens
    
    let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profilepicture")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageview)))
        profileImage.layer.cornerRadius = 100
        profileImage.layer.masksToBounds = true
        profileImage.isUserInteractionEnabled = true
        
        return profileImage
    }()
    
    //x, y, width, heigh
    func profileImageContraits(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func handleSelectProfileImageview(){
        
    }
    
    let userDataContainer: UIView = {
       let userContainer = UIView()
        userContainer.backgroundColor = UIColor(r: 110, g: 96, b: 4)
        
        
        return userContainer
    }()
    
    func userDataContainerContraits(){
        //x, y, width, heigh
        userDataContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userDataContainer.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50).isActive = true
        userDataContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        userDataContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    
}

//    let backgroundProfileView: UIView = {
//        let backgroundProfile = UIView()
//
//        backgroundProfile.backgroundColor = UIColor.gray
//        backgroundProfile.translatesAutoresizingMaskIntoConstraints = false
//
//        return backgroundProfile
//    }()
//    //contraits
//    //x, y, width, heigh
//    func backgroundProfileContraits(){
//        backgroundProfileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        backgroundProfileView.bottomAnchor.constraint(equalTo: userDataContainer.topAnchor).isActive = true
//        backgroundProfileView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        backgroundProfileView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//    }


