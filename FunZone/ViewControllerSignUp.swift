//
//  ViewControllerSignUp.swift
//  FunZone
//
//  Created by Xavier on 6/2/22.
//

import UIKit

class ViewControllerSignUp: UIViewController {

    @IBOutlet weak var switchRememberMeSignUp: UISwitch!
    @IBAction func buttonDeleteDidTouchUpInside(_ sender: Any) {
        buttonDeleteDidTouchUpInside_deleteUser(username: textFieldUsername.text!)
    }
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBAction func buttonSubmitDidTouchUpInside(_ sender: Any) {
        buttonSubmitDidTouchUpInside_SignUp()
    }
    @IBOutlet weak var labelEWMessage: UILabel! //UIlabel for error/warning message
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewDidLoad_HideMsgLabel()
        
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


extension ViewControllerSignUp {
    //viewDidLoad - update message text and textColor
    func viewDidLoad_HideMsgLabel() {
        labelEWMessage.textColor = view.backgroundColor
        labelEWMessage.text = ""
    }
    //buttonSubmitDidTouchUpInside - 1. validate username & password input + EWMsg Update
    func buttonSubmitDidTouchUpInside_inputValidation(input : String?) -> Bool {
        var inputIsValid = false
        if input != nil && input! != "" && !input!.isEmpty {
            inputIsValid = true
        }
        return inputIsValid
    }
    //buttonSubmitDidTouchUpInside - 2. check if user is new + EWMsg Update
    func buttonSubmitDidTouchUpInside_isNewUser(username : String) -> Bool {
        let isNewUser = !DBHelpUser.dbHelperUser.userDoesExist(username: username)
        return isNewUser
    }
    //buttonSubmitDidTouchUpInside - 3. create new user + EWMsg Update
    func buttomSubmitDidTouchUpInside_createNewUser(username : String, password : String) {
        DBHelpUser.dbHelperUser.createUser(username: username, password: password)
    }
    //buttonSubmitDidTouchUpInside - 4. save user credential to keychain if remember me is switched on
    
    //buttonSubmitDidTouchUpInside
    func buttonSubmitDidTouchUpInside_SignUp() {
        let username = textFieldUsername.text
        let password = textFieldPassword.text
        //error handling for invalid input
        if buttonSubmitDidTouchUpInside_inputValidation(input: username) && !buttonSubmitDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter password."
        }
        if !buttonSubmitDidTouchUpInside_inputValidation(input: username) && buttonSubmitDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter username."
        }
        if !buttonSubmitDidTouchUpInside_inputValidation(input: username) && !buttonSubmitDidTouchUpInside_inputValidation(input: password) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter username and password."
        }
        if buttonSubmitDidTouchUpInside_inputValidation(input: username) && buttonSubmitDidTouchUpInside_inputValidation(input: password) {
            print("Valid input.")
            //if user already exists populate error msg
            if !buttonSubmitDidTouchUpInside_isNewUser(username: username!) {
                labelEWMessage.textColor = .red
                labelEWMessage.text = "Username exists. Pleaes go back to sign in."
            } else {
                //read remember me switch and save in keychain
                if switchRememberMeSignUp.isOn {
                    buttonSubmitDidTouchUpInside_SaveUserCredential(username: username!)
                } else {
                    print("switch remember me is off")
                    let userDefaults = UserDefaults.standard
                    userDefaults.set("", forKey: "lastUser")
                }
                //create new user in core data
                buttomSubmitDidTouchUpInside_createNewUser(username: username!, password: password!)
                labelEWMessage.textColor = .black
                labelEWMessage.text = "Thank you for signing up! Please sign in."
            }
        }
    }
}

extension ViewControllerSignUp {
    //DEV USE ONLY
    func buttonDeleteDidTouchUpInside_deleteUser(username : String) {
        DBHelpUser.dbHelperUser.deleteUser(username: username)
        print("User deleted.")
    }
}

extension ViewControllerSignUp { //remember me switch functionalities
//    func buttonSubmitDidTouchUpInside_LastSignUp(username : String) {
//        let userDefault = UserDefaults.standard
//        userDefault.set(username, forKey: "lastSignUpUser")
//    }
//    func buttonSubmitDidTouchUpInside_RememberMe(username : String) {
//        let userDefault = UserDefaults.standard
//        userDefault.set(switchRememberMeSignUp.isOn, forKey: "switchRememberMeSignUpIsOnFor\(username)")
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
    func buttonSubmitDidTouchUpInside_SaveUserCredential(username : String) {
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
}
