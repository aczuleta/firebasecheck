//
//  EmailViewController.swift
//  authenticationFirebase
//
//  Created by ANDRES ZULETA on 7/10/17.
//  Copyright © 2017 isis3510. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class EmailViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        let keyChain2 = KeychainWrapper.defaultKeychainWrapper.removeObject(forKey: "uid")
        print("se deslogueo \(keyChain2)")
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
