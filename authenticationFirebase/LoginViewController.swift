//
//  LoginViewController.swift
//  authenticationFirebase
//
//  Created by ANDRES ZULETA on 3/10/17.
//  Copyright © 2017 isis3510. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToSignUp", sender: nil)
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Error: No se pudo autenticar con facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Error: El usuario canceló la autenticación con facebook")
            } else {
                print("JESS: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }

    }

    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JESS: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                     self.performSegue(withIdentifier: "goToEmail", sender: nil)
                }
                
                /** if let user = user {
                    let userData = ["provider": credential.provider]
                    //self.completeSignIn(id: user.uid, userData: userData)
                } */
            }
        })
    }

    @IBAction func loginWithEmail(_ sender: Any) {
        
        if let email1 = emailTxt.text, let pass = passTxt.text {
            Auth.auth().signIn(withEmail: email1, password: pass, completion: {(user, error) in
                if error == nil {
                    print("Email user authenticated with firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                        self.performSegue(withIdentifier: "goToEmail", sender: nil)
                    }
                    
                } else {
                    
                    /**self.showAlert(title: "Inicio Inválido", message: "El nombre de usuario y/o contraseña son incorrectos", closeButtonTitle: "Cerrar")*/
                    return
                }
            })
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let cache  = KeychainWrapper.defaultKeychainWrapper.string(forKey: "uid") {
            self.performSegue(withIdentifier: "goToEmail", sender: nil)
            print("Hay una sesión activa")
        }

    }

    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: "uid")
       
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
