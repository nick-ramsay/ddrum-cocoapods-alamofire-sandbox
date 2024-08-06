//
//  ViewController.swift
//  iOSAlamofireSandbox
//
//  Created by Nick Ramsay on 10/7/2024.
//

import UIKit
import DatadogCore
import DatadogRUM
import DatadogInternal
import Alamofire




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchUsers() {
            let url = "https://dummyjson.com/users"
            
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("Data: \(data)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    
    @IBAction func buttonTapped(_ sender: Any) {
        // Your function logic here
        fetchUsers()
    }

}

