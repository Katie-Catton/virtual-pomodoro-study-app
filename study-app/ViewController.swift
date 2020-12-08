//  ViewController.swift
//  virtual-pomodoro-study-app

//
//  Created by Matthew Kim on 12/08/20.
//  Copyright © 2020 Matthew Kim. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var emailField: UITextField!
    var passwordLabel: UILabel!
    var passwordField: UITextField!
    var loginButton: UIButton!
    var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        
        nameLabel = UILabel()
        nameLabel.text = "Sign In"
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        emailLabel = UILabel()
        emailLabel.text = "Email:"
        emailLabel.textColor = UIColor.black
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        emailField = UITextField()
        emailField.text = "Enter your Email"
        emailField.textColor = UIColor.black
        emailField.textAlignment = NSTextAlignment.left
        emailField.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password:"
        passwordLabel.textColor = UIColor.black
        passwordLabel.textAlignment = NSTextAlignment.left
        passwordLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        passwordField = UITextField()
        passwordField.text = "Enter your Password"
        passwordField.textColor = UIColor.black
        passwordField.textAlignment = NSTextAlignment.left
        passwordField.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)
        
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("Login", for: .normal)
        loginButton.sizeToFit()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        loginButton.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        loginButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowRadius = 0
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 29
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 88, bottom: 16, right: 88)
        //loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        //signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.addSubview(signUpButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
        nameLabel.heightAnchor.constraint(equalToConstant: 40),
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140)
        ])
        // *createButton
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
              
              // *joinButton
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func Login() {
        
    }

}


}
