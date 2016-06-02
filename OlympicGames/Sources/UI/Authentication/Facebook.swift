//
//  Facebook.swift
//  OlympicGames
//
//  Created by Macbook on 22/05/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

extension UIViewController {
    func facebookLogin (sender: AnyObject){
        let facebookLogin = FBSDKLoginManager()
        let myRoothRef = DataService.dataService.BASE_REF
        print("Logging In")
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self.navigationController!.topViewController!, handler:{(facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            }
            else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            }
            else {
                print("You’re in ;)")
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                myRoothRef.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock:
                    { error, authData in
                        
                        if error != nil {
                            print("Login failed : \(error)")
                        }
                        else {
                            print("Logged in : \(authData)")
                            
                            let newUser = [
                                USER_PROVIDER: authData.provider,
                                USER_NAME: authData.providerData["displayName"] as? String,
                                USER_EMAIL : authData.providerData["email"] as? String
                            ]
                            
                            myRoothRef.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser)
                        }
                        
                    }
                )
            }
        });
    }
}