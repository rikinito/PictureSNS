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
        emailTextField.text="malkods0505akbnmoms@gmail.com"
        passwordTextField.text = "12345"
        
        passwordTextField.isSecureTextEntry = true
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
    
    func login(_ mail: String, password: String) {
        NCMBUser.logInWithMailAddress(inBackground: mail, password: password) { (user, error) in
            print(mail)
            print(password)
            
            if error != nil {
                print(error?.localizedDescription)
                
                let alert = UIAlertController(title: "ユーザー認証失敗", message: "再度メールアドレスとパスワードを入力してください", preferredStyle: .alert)
                let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                let btn2 = UIAlertAction(title: "パスワードをリセット",style: .default) { (action) in
                    self.presentEmailTextField()
                    
                }
                
                
                alert.addAction(btn)
                alert.addAction(btn2)
                self.present(alert, animated: true, completion: nil)
                
                
            }else {
                if (user?.isAuthenticated())! {
                    self.performSegue(withIdentifier: "toTimeLine", sender: nil)
                    print("ログイン成功")
                }else {
                    self.presentAuthAlert()
                }
            }
        }
        
               
    }
    
    func requestResetPassword(email address: String) {
        NCMBUser.requestPasswordResetForEmail(inBackground: address) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }
    
    func presentEmailTextField() {
        let alert = UIAlertController(title: "パスワードをリセット", message: "パスワードをリセットするためのメールアドレスを記入してください", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Email Address"
        }
        let btn = UIAlertAction(title: "メールを送信", style: .default) { (action) in
            if let textField: UITextField = alert.textFields![0] {
                if let text = textField.text {
                    self.requestResetPassword(email: text)
                }else {
                    print("メールアドレスが記入されてないよ")
                }
                
            }
        }
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAuthAlert() {
        let alert = UIAlertController(title: "ユーザー認証失敗", message: "再度メールアドレスとパスワードを入力してください", preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        
        
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("タッチ")
        if (self.emailTextField.isFirstResponder) {
            self.emailTextField.resignFirstResponder()
            
        }else if(self.passwordTextField.isFirstResponder) {
            self.passwordTextField.resignFirstResponder()
        }
        
    }
    
    func logout() {
        NCMBUser.logOut()
        
    }
    
}
