//
//  LoginViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/09/18.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        emailTextField.delegate = self
//        passwordTextField.delegate = sself
        
        passwordTextField.secureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectLogin() {
        guard let mail = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        self.login(mail, password: password)
    }
    
    @IBAction func selectForgetPassword() {
        self.presentEmailTextField()
    }
    
    func login(mail: String, password: String) {
        NCMBUser.logInWithMailAddressInBackground(mail, password: password) { (user, error) in
            print(mail)
            print(password)
            
            if error != nil {
                print(error.localizedDescription)
            }else {
                if user.isAuthenticated() {
                    self.performSegueWithIdentifier("toTimeLine", sender: nil)
                    print("ログイン成功")
                }else {
                    self.presentAuthAlert()
                }
            }
        }
        
//        let user = NCMBUser()
//        //ユーザー名を設定
//        user.userName = "user1"
//        //パスワードを設定
//        user.password = "password1"
//        //会員の登録を行う
//        user.signUpInBackgroundWithBlock{(error: NSError!) in
//            if error != nil {
//                // 新規登録失敗時の処理
//                print("新規登録失敗")
//                
//            }else{
//                // 新規登録成功時の処理
//                print("新規登録成功")
//                
//            }
//        }
//        
//        // ユーザー名とパスワードでログイン
//        NCMBUser.logInWithUsernameInBackground("user1", password: "password1", block:{(user: NCMBUser!, error: NSError!) in
//            if error != nil {
//                // ログイン失敗時の処理
//                print("ログイン失敗")
//                
//            }else{
//                // ログイン成功時の処理
//                print("ログイン成功")
//                
//            }
//        })
//        
        
    }
    
    func requestResetPassword(email address: String) {
        NCMBUser.requestPasswordResetForEmailInBackground(address) { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    func presentEmailTextField() {
        let alert = UIAlertController(title: "パスワードをリセット", message: "パスワードをリセットするためのメールアドレスを記入してください", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter Email Address"
        }
        let btn = UIAlertAction(title: "Finish", style: .Default) { (action) in
            if let textField: UITextField = alert.textFields![0] {
                if let text = textField.text {
                    self.requestResetPassword(email: text)
                }else {
                    print("メールアドレスが記入されてないよ")
                }
                
            }
        }
        alert.addAction(btn)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func presentAuthAlert() {
        let alert = UIAlertController(title: "ユーザー認証失敗", message: "メールアドレスの認証を行ってください。", preferredStyle: .Alert)
        let btn = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(btn)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func logout() {
        NCMBUser.logOut()
        
    }
}