//
//  ViewController.swift
//  LoginWith
//
//  Created by Vijay Pratap Singh on 5/22/17.
//  Copyright © 2017 Vijay Pratap Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        print("fetch profile")
        let parameters = ["fields": "email, first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil {
                print(error ?? "error")
                return
            }
            
            let resultValue = result as? NSDictionary
            if let email = resultValue?["email"] as? String{
                print(email)
            }
            
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("login complete")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

