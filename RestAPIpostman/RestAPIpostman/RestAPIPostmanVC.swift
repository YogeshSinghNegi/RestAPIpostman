//
//  RestAPIPostmanVC.swift
//  RestAPIpostman
//
//  Created by appinventiv on 09/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit
import Foundation

//=============================================================//
//MARK: RestAPIPostmanVC Class
//=============================================================//

class RestAPIPostmanVC: UIViewController {
    
//=============================================================//
//MARK: Defining Properties
//=============================================================//
    
    // To Store the data coming from response
    var form = [String:Any]()
    
//=============================================================//
//MARK: Defining IBOutlets
//=============================================================//
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var fieldText: UITextField!
    
    @IBOutlet weak var myLoader: UIActivityIndicatorView!
    
//=============================================================//
//MARK: viewDidLoad() method
//=============================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially loader is hidden
        self.stopLoader()
    }
    
    // To enable keyboard to hide while not typing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
//=============================================================//
//MARK: Defining IBAction
//=============================================================//

    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        // Starting the loader
        self.startLoader()
        
        // Calling our restAPICall()
        self.restAPICall()
        
        // Small Delay while the data arrives
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {
           
            self.stopLoader()
            
            // Navigating to the SignUpDataVC View Controller
            guard let SignUpDataObj = self.storyboard?.instantiateViewController(withIdentifier: "SignUpDataVC_ID") as? SignUpDataVC else { fatalError("SignUpDataVC not initialised") }

            SignUpDataObj.form = self.form
            
            self.navigationController?.pushViewController(SignUpDataObj, animated: true)
        }
    }
    
    // Method contains all the logics To Hit an Rest API
    func restAPICall() {
        
        // Defining Header
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "9ddefa8f-17b6-bf4f-7d87-9751f6497214"
        ]
        
        // Defining Body of the Request
        let postData = NSMutableData(data: "name=yogesh".data(using: String.Encoding.utf8)!)
        postData.append("&id=323".data(using: String.Encoding.utf8)!)
        postData.append("&username=\(self.nameText.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&field=\(self.fieldText.text!)".data(using: String.Encoding.utf8)!)
        
        // URL as Request
        let request = NSMutableURLRequest(url: NSURL(string: "https://httpbin.org/post")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        // Request sent and recieved Response
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let err = error {
                print(err)
            } else {
                
                // Returns a Foundation object from given JSON data.
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                
                // Data is converted to get desired data
                guard let dict = json as? [String:Any] else { fatalError("dict not memorised") }
                
                self.form = dict["form"] as! [String : Any]
                
            }
        })
        
        dataTask.resume()
        
    }
    
//=============================================================//
//MARK: myLoader Start and Stop Methods
//=============================================================//
    
    func startLoader() {
        
        self.myLoader.isHidden = false
        self.myLoader.startAnimating()
        self.myLoader.hidesWhenStopped = true
        
    }
    
    func stopLoader() {
        
        self.myLoader.stopAnimating()
        self.myLoader.isHidden = true
        
    }

}

