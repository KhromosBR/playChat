//
//  LoginController + handlers.swift
//  loginTestSwift-firebase
//
//  Created by Ricardo Duarte Sampaio on 2017-05-03.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func handleRegister(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("form is not valid")
            return
        }
                                                                                                /**/
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if let error = error{
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //Successfully autenticated
            //To create a unic ID to each image
            let imageName = UUID().uuidString
            let storageReference = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1){
            
            //creating binary data to upload
//            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                //Autenticate the user
                storageReference.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    //registering the user with the image into firebase database
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                            let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        
                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                    }
                })
            }

        })
    }
    //----------------------------------------------------------------------------------------------------
    
    private func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference(fromURL: "https://play-chat-31de6.firebaseio.com/")
        
        //creating a new child of users to organize the firebase data
        let usersReference = ref.child("Users").child(uid)

        usersReference.onDisconnectUpdateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err{
                print(err)
                return
            }
//            self.messagesController?.fetchUserAndSetupNavBarTitle()
            //send the name of the user loged in to the navigation title
            let user = User(dictionary: values)
            self.messagesController?.setupNavbarWithUser(user)
            
            self.dismiss(animated: true, completion: nil)
            print("Saved user successfully into Firebase Database")
        })
    }
    //----------------------------------------------------------------------------------------------------
    
    //Handle select profile Image - pickerController
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}


