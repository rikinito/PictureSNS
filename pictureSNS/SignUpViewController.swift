//
//  SignUpViewController.swift
//  pictureSNS
//
//  Created by 仁藤吏紀 on 2016/09/18.
//  Copyright © 2016年 仁藤吏紀. All rights reserved.
//

import UIKit



class SignUpViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSignup() {
        
        
        let email = "malkods0505akbnmoms@gmail.com"
        let pass = "12345"
        let name = "Riki"
        let confirm = "12345"

        
        print("ログイン")
//        guard let email = emailTextField.text else { return }
//        guard let pass = passwordTextField.text else { return }
//        guard let name = nameTextField.text else { return }
//        guard let confirm = confirmPasswordTextField.text else { return }
        print(email)
        print(pass)
        print(confirm)
        print(name)
        if confirm.isEqual(pass) {
            self.signup(email, password: pass, username: name)
        }else {
            self.presentPassConfirmAlert()
        }
    }
    
    @IBAction func didSelectToLogin() {
        self.transition()
    }
    
    func signup(_ mail: String, password: String, username: String) {
        let user = NCMBUser(className: "user")
        user?.password = password
        user?.mailAddress = mail
        user?.userName = username
        if user?.isNew == false {
//            user.signUpInBackgroundWithBlock { (error) in
//                if error != nil {
//                    print(error.localizedDescription)
//                }else {
//                    //self.requestAuthentication(email: mail)
//                    var error : NSError? = nil
//                    //NCMBUser.requestAuthenticationMail(mail, error: &error)
//               }
//            }
            
             self.requestAuthentication(email: mail)
            
        
        }else {
            print("ユーザーネームかぶっているよ")
            self.presentCheckUsernameAlert()
        }
    }
    
    func requestAuthentication(email address: String) {
        NCMBUser.requestAuthenticationMail(inBackground: address, block: { (error) in
            if error != nil {
                //print(error?.localizedDescription)
            }else {
                
                let alert = UIAlertController(title: "メール認証", message: "メール認証をしてください", preferredStyle: .alert)
                let btn = UIAlertAction(title: "OK", style: .default) { (action) in self.dismiss(animated: true, completion: nil)                                   }
                alert.addAction(btn)
                self.present(alert, animated: true, completion: nil)



                //self.transition()
            }
        })
    }
    
    func presentPassConfirmAlert() {
        let alert = UIAlertController(title: "パスワードが一致しません", message: "パスワードが一致しなかったので、もう一度入力してください", preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default) { (action) in
            self.confirmPasswordTextField.text = ""
            self.passwordTextField.text = ""
        }
        alert.addAction(btn)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentCheckUsernameAlert()  {
        let alert = UIAlertController(title: "ユーザーネームエラー", message: "記入されたユーザーネームは既に登録されています。\n違うユーザーネームを記入してください", preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.nameTextField.text = ""
        }
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
    }
    
    func toView()  {
        self.performSegue(withIdentifier: "toView", sender: nil)
    }
    
    func transition() {
        self.performSegue(withIdentifier: "toLoginView", sender: nil)
    }
    
    
 
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("タッチ")
        if (self.emailTextField.isFirstResponder) {
            self.emailTextField.resignFirstResponder()
            
        }else if(self.passwordTextField.isFirstResponder) {
            self.passwordTextField.resignFirstResponder()
            
        }else if(self.confirmPasswordTextField.isFirstResponder) {
            self.confirmPasswordTextField.resignFirstResponder()
            
        }else if(self.nameTextField.isFirstResponder) {
            self.nameTextField.resignFirstResponder()
            
        }

    }
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
