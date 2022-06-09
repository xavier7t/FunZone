//
//  ViewControllerSignIn.swift
//  FunZone
//
//  Created by Xavier on 6/2/22.
//

import UIKit

class ViewControllerSignIn: UIViewController {

    @IBOutlet weak var switchRememberMeSignIn: UISwitch!
    @IBAction func buttonSignInDidTouchUpInside(_ sender: Any) {
        buttonSignInDidTouchUpInside_SignIn()
    }
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var labelEWMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefault = UserDefaults.standard
        textFieldUsername.text = userDefault.string(forKey: "lastUser")
        viewDidLoad_HideMsgLabel()
        viewDidLoad_PopulateCredentialInKeyChain()
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

extension ViewControllerSignIn {
    //viewDidLoad - update message text and textColor
    func viewDidLoad_HideMsgLabel() {
        labelEWMessage.textColor = view.backgroundColor
        labelEWMessage.text = ""
    }
    //buttonSignInDidTouchUpInside - 1. validate username & password input + EWMsg Update
    func buttonSignInDidTouchUpInside_inputValidation(input : String?) -> Bool {
        var inputIsValid = false
        if input != nil && input! != "" && !input!.isEmpty {
            inputIsValid = true
        }
        return inputIsValid
    }
    func buttonSignInDidTouchUpInside_SignIn() {
        let username = textFieldUsername.text
        let password = textFieldPassword.text
        //error handling for invalid input
        if buttonSignInDidTouchUpInside_inputValidation(input: username) && !buttonSignInDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter password."
        }
        if !buttonSignInDidTouchUpInside_inputValidation(input: username) && buttonSignInDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter username."
        }
        if !buttonSignInDidTouchUpInside_inputValidation(input: username) && !buttonSignInDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter username and password."
        }
        if buttonSignInDidTouchUpInside_inputValidation(input: username) && buttonSignInDidTouchUpInside_inputValidation(input: password) {
            print("Valid input.")
            //if user does not exist populate error msg
            if !DBHelpUser.dbHelperUser.userDoesExist(username: username!) {
                labelEWMessage.textColor = .red
                labelEWMessage.text = "User not found. Sign up first."
            } else {
                //verify if password is correct
                let user = DBHelpUser.dbHelperUser.readUser(username: username!)
                if user.password != password! {
                    labelEWMessage.textColor = .red
                    labelEWMessage.text = "Password incorrect."
                } else {
                    print("Login successfully.")
                    //if remember me is on, save user credential in keychain
                    //read remember me switch and save in keychain
                    if switchRememberMeSignIn.isOn {
                        buttonSignInDidTouchUpInside_RememberMe(username: username!)
                    } else {
                        let userDefaults = UserDefaults.standard
                        userDefaults.set("", forKey: "lastUser")
                        print("switch remember me is off")
                    }
                    //present the tab bar controller in full screen
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                    //show the tab controller as an instantiated vc
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true, completion: nil)
                }
            }
        }
    }
}

extension ViewControllerSignIn { //remember me switch functionalities
//    func viewDidLoad_CheckLastSignInUp() { //populate the username & password if signed in/signed up user switched on remember me
//        //get the last user who signed up
//        let userDefault = UserDefaults.standard
//        let lastSignUpUser = userDefault.string(forKey: "lastSignUpUser")
//        let switchRememberMeSignUpLastUser = userDefault.bool(forKey: "switchRememberMeSignUpIsOnFor\(lastSignUpUser)")
//        if switchRememberMeSignUpLastUser {
//            let userDefault = UserDefaults.standard
//            userDefault.set(false, forKey: "switchRememberMeSignUpIsOnFor\(lastSignUpUser)")
//            viewDidLoad_PopulateUserCredential(username: lastSignUpUser!)
//        } else {
//            //if last signup user didnt switch on remember me, check if last signin user switched on remember me
//            viewDidLoad_CheckRememberedSignin()
//        }
//    }
//    func viewDidLoad_CheckRememberedSignin() { //
//        //get the last user who signed in
//        let userDefault = UserDefaults.standard
//        let lastSignInUser = userDefault.string(forKey: "lastSignInUser")
//        let switchRememberMeSignInLastUser = userDefault.bool(forKey: "switchRememberMeSignInIsOnFor\(lastSignInUser)")
//        if switchRememberMeSignInLastUser {
//            viewDidLoad_PopulateUserCredential(username: lastSignInUser!)
//        }
//    }
//    func viewDidLoad_PopulateUserCredential(username : String) {
//        //update signin remember me to false saved in backend
//        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username, kSecReturnAttributes as String : true, kSecReturnData as String : true]
//        var response : CFTypeRef?
//        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
//            let data = response as? [String : Any]
//            let username = data![ kSecAttrAccount as String] as? String
//            let passwordEncrypted = (data![ kSecValueData as String] as? Data)!
//            let passwordUnencrypted = String(data: passwordEncrypted, encoding: .utf8)
//            print(username!,passwordUnencrypted!)
//            textFieldUsername.text = username!
//            textFieldPassword.text = passwordUnencrypted!
//            print("User: \(username!)")
//            print("Passwowrd: \(passwordUnencrypted!)")
//        } else {
//            print("Error.")
//        }
//    }
//    func buttonSignInDidTouchUpInside_RememberMe(username : String) {
//        let userDefault = UserDefaults.standard
//        userDefault.set(username, forKey: "lastSignInUser")
//        userDefault.set(switchRememberMeSignIn.isOn, forKey: "switchRememberMeSignInIsOnFor\(username)")
//
//        //save user credential to keychain
//        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : username, kSecValueData as String : textFieldPassword.text!.data(using: .utf8)]
//
//        if SecItemAdd(attribute as CFDictionary, nil) == noErr {
//            print("User credential saved in Keychain.")
//        } else {
//            print("Error: Cannot save user credential in Keychain.")
//        }
//    }
    func buttonSignInDidTouchUpInside_RememberMe(username : String) {
        //get keychain username from last time in UD
        let userDefault = UserDefaults.standard
        let lastUser = userDefault.string(forKey: "lastUser")
        
        //update keychain credential
        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : textFieldUsername.text]
        
        let attributeUsername : [String : Any] = [kSecAttrAccount as String : username]
        let attributePassword : [String : Any] = [kSecValueData as String : textFieldPassword.text!.data(using: .utf8)]
        
        if SecItemUpdate(request as CFDictionary, attributePassword as CFDictionary) == noErr && SecItemUpdate(request as CFDictionary, attributeUsername as CFDictionary) == noErr {
            print("Credential updated in keychain.")
        } else {
            print("Error.")
        }
        //update keychain username to this time in UD
        userDefault.set(username, forKey: "lastUser")
    }
    
    func viewDidLoad_PopulateCredentialInKeyChain() {
        //populate username
        let userDefault = UserDefaults.standard
        textFieldUsername.text = userDefault.string(forKey: "lastUser")
        
        //populate password
        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : textFieldUsername.text, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        var response : CFTypeRef?
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            let data = response as? [String : Any]
            let username = data![ kSecAttrAccount as String] as? String
            let passwordEncrypted = (data![ kSecValueData as String] as? Data)!
            let passwordUnencrypted = String(data: passwordEncrypted, encoding: .utf8)
            print(username!,passwordUnencrypted!)
            textFieldPassword.text = passwordUnencrypted
        } else {
            print("Error.")
        }
    }
}
