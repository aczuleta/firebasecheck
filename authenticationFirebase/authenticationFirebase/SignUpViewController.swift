//
//  SignUpViewController.swift
//  authenticationFirebase
//
//  Created by ANDRES ZULETA on 7/10/17.
//  Copyright © 2017 isis3510. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpViewController: UIViewController {

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
     
        if let email1 = emailTxt.text, let pass = passTxt.text {
            Auth.auth().createUser(withEmail: email1, password: pass, completion: {(user,error) in
                if error != nil{
                    print("Unable to authenticate with firebase email")
                    /**self.showAlert(title: "Error", message: "Ingrese una dirección de correo válida", closeButtonTitle: "Cerrar")*/
                }
                else {
                    print("successfully authenticated wth firebase email")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                        self.performSegue(withIdentifier: "goToEmail", sender: nil)
                    }
                }
            })
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
