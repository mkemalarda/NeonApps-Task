//
//  ViewController.swift
//  InstagramTask
//
//  Created by Mustafa Kemal ARDA on 16.02.2024.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        
        
    
        
        
        
        
        createUI()
        
        
    }
    
    func createUI(){
        //MARK: - Properties
        let titleLabel = UILabel()
        titleLabel.text = "Login Screen"
        titleLabel.textAlignment = .center
        //   titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .systemBlue
        titleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        emailTextField.placeholder = "email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(30)
        }
        
        passwordTextField.placeholder = "password"
        passwordTextField.borderStyle = .roundedRect
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        
        
        let signInButton = UIButton()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.layer.cornerRadius = 15
        signInButton.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100)
        }
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .systemPink
        signUpButton.layer.cornerRadius = 15
        signUpButton.addTarget(self, action: #selector(createButton), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(100)
        }
        
    }
    
    @objc func clickedButton(){
        print("User id: \(Auth.auth().currentUser?.uid)")
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    let vc = TabBarVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
            
        }
        
    }
    
    @objc func createButton(){
        
        if emailTextField.text != ""  && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    let vc = TabBarVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String ){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


//#Preview(body: {
//    ViewController()
//})
//
