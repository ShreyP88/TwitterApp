//
//  loginViewController.swift
//  Twitter
//
//  Created by Shreyas Pant on 10/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
            self.performSegue(withIdentifier: "Login2Home", sender: self)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let requestToken = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: requestToken, success: {
            UserDefaults.standard.set(true, forKey: "loggedIn")
            self.performSegue(withIdentifier: "Login2Home", sender: self)
            
        }, failure: { (Error) in
            print("Failed to login")
        })
    }

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
