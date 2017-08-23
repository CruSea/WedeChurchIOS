//
//  SignUpViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration

class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    public class func standardController() -> SignupViewController {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as! SignupViewController
//    }
    
    var dictResponse: NSDictionary = [:]
    var dictProfile : NSDictionary = [:]
    
    @IBOutlet var getGender: UIPickerView! = UIPickerView()
    
    let gender = ["", "Male", "Female", "Other"]
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak public var txtAreaCode: UITextField!
    @IBOutlet weak public var txtPhone: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtconfPass: UITextField!
    
    @IBOutlet weak public var countryButton: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnAlready: UIButton!
    
    var AreaCode: NSString? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtGender.delegate = self
        txtCountry.delegate = self
        txtAreaCode.delegate = self
        txtPhone.delegate = self
        txtPass.delegate = self
        txtconfPass.delegate = self
        
        txtAreaCode.adjustsFontSizeToFitWidth = true
        btnAlready.titleLabel?.adjustsFontSizeToFitWidth = true
        
        getGender.isHidden = true
        self.txtGender.inputAccessoryView = getGender
        
        let fontSize = phoneConstant.deviceWidth/20
        
        txtName.font = UIFont(name: txtName.font!.fontName , size: fontSize)
        txtEmail.font = UIFont(name: txtEmail.font!.fontName , size: fontSize)
        txtGender.font = UIFont(name: txtGender.font!.fontName , size: fontSize)
        txtCountry.font = UIFont(name: txtCountry.font!.fontName , size: fontSize)
        txtAreaCode.font = UIFont(name: txtAreaCode.font!.fontName , size: fontSize)
        txtPhone.font = UIFont(name: txtPhone.font!.fontName , size: fontSize)
        txtPass.font = UIFont(name: txtPass.font!.fontName , size: fontSize)
        txtconfPass.font = UIFont(name: txtconfPass.font!.fontName , size: fontSize)
        
        btnSignup.titleLabel!.font = UIFont(name: btnSignup.titleLabel!.font!.fontName , size: fontSize)
        countryButton.titleLabel!.font = UIFont(name: countryButton.titleLabel!.font!.fontName , size: fontSize)
        // Do any additional setup after loading the view.
    }
    
    
    // returns the # of rows in each component..
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        txtGender.text = gender[row]
        getGender.isHidden = true
        
        self.txtPhone.becomeFirstResponder()
    }
    
    @IBAction func ClickedSignUp(_ sender: Any) {
        view.endEditing(true)
        if ((txtName.text?.length)! > 0 && (txtEmail.text?.length)! > 0 && (txtGender.text?.length)! > 0 && (txtCountry.text?.length)! > 0 && (txtAreaCode.text?.length)! > 0 && (txtPhone.text?.length)! > 0 && (txtPass.text?.length)! > 0 && (txtconfPass.text?.length)! > 0) {
            
            if (txtEmail.text?.isValidEmail())! {
                print("valid email")
                if (txtPass.text == txtconfPass.text){
                    
                    if isInternetAvailable() {
                        self.registerNewUser()
                    }else{
                        self.displayMyAlertMessage(userMessage: "You are not connected to the internet. Please connect to the internet to perform this action.");
                      //  presentAlertWithTitle(title: "No internet access", message: "You are not connected to the internet. Please connect to the internet to perform this action.")
                    }
                    
                }else{
                    print("Passwords do not match, please retype")
                    self.txtPass.text = nil
                    self.txtconfPass.text = nil
                    self.txtPass.becomeFirstResponder()
                    self.displayMyAlertMessage(userMessage: "Passwords do not match, please retype");
                   // self.presentAlertWithTitle(title: "Sorry", message: "Passwords do not match, please retype")
                }
                
            }else{
                print("invalid email")
                self.txtEmail.text = nil
                self.txtEmail.becomeFirstResponder()
                self.displayMyAlertMessage(userMessage: "Invalid email address.");
               // self.presentAlertWithTitle(title: "Sorry", message: "Invalid email address.")
            }
        }else{
            print("All fields are required")
            self.displayMyAlertMessage(userMessage: "All fields are required");
           // self.presentAlertWithTitle(title: "Sorry", message: "All fields are required")
        }
        
    }
    func registerNewUser(){
//        self.showMBProgressHUD()
        
        let str = txtAreaCode.text
        AreaCode = str?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil) as NSString?
        print(AreaCode as Any)
        // prepare json data
        let myArrayOfDict :[[String:AnyObject]] = [["User_Country":AreaCode as AnyObject,
                                                    "email":txtEmail.text as AnyObject,
                                                    "sex":txtGender.text as AnyObject,
                                                    "user_name":txtName.text as AnyObject,
                                                    "user_pass":txtPass.text as AnyObject,
                                                    "User_Phone":txtPhone.text as AnyObject]]
        
        print(myArrayOfDict.toJSONString())
        
        let json = ["user_name":txtName.text!, "user_pass":txtPass.text!,"service":"register", "Param": myArrayOfDict.toJSONString()] as [String : Any]
        print(json)
        // create post request
        let url = NSURL(string: "http://wede.myims.org/api")!
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           // self.hideMBProgressHUD()
            
            if let error = error {
                self.displayMyAlertMessage(userMessage: error.localizedDescription);

               // self.presentAlertWithTitle(title: "Sorry", message: error.localizedDescription)
                return
            }
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else { return }
                print("json:", json)
                
                if let Request_Error = json["Request_Error"] as? NSDictionary {
                    self.displayMyAlertMessage(userMessage: (Request_Error.allValues.first as? String ?? "")!);
                  //  self.presentAlertWithTitle(title: "Sorry", message: (Request_Error.allValues.first as? String ?? "")!)
                }else if let Response = json["response"] as? NSDictionary {
                    self.dictResponse = Response
                    print("response=",self.dictResponse)
                    
                    UserDefaults.standard.set(self.txtPass.text, forKey: "password")
                    UserDefaults.standard.set(self.txtEmail.text, forKey: "email")
                    UserDefaults.standard.set(self.txtPhone.text, forKey: "phone")
                    UserDefaults.standard.synchronize()
                    
                    self.performSegue(withIdentifier: "showHome", sender: self)
                    
                }else{}
                
            } catch {
                print("error:", error)
                self.displayMyAlertMessage(userMessage: error.localizedDescription);

               // self.presentAlertWithTitle(title: "Sorry", message: error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    

    
    @IBOutlet weak public var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    

    
    @IBAction fileprivate func tappedBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        getGender.isHidden = true
    }
    
    
    public var phoneNumberIsValid: Bool {
        if let phoneNumberLength = txtPhone.text?.length {
            return phoneNumberLength > 5 && phoneNumberLength < 15
        }
        return false
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
}
extension String {
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
}
extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}

private extension String {
    var length: Int {
        return utf16.count
    }
}
