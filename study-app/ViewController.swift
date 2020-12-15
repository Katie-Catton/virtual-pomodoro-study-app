//  ViewController.swift
//  virtual-pomodoro-study-app

//
//  Created by Matthew Kim on 12/08/20.
//  Copyright © 2020 Matthew Kim. All rights reserved.
//
import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var tomatoLogo: UIImageView!
    var emailField: UITextField!
    var passwordLabel: UILabel!
    var passwordField: UITextField!
    var loginButton: GIDSignInButton!
    var buttonBox: UIView!
    //var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // Do any additional setup after loading the view.


        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
        // added a call to this procedure to format the navigation bar for the entire app
        // please don't remove
        // -Katie
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
    }
    
    // modifies default navigation bar
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 25)!], for: .normal)
    }
    
    func setupViews() {
        
        nameLabel = UILabel()
        nameLabel.text = "Pomodoro with Friends!"
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        tomatoLogo = UIImageView()
        tomatoLogo.translatesAutoresizingMaskIntoConstraints = false
        tomatoLogo.contentMode = .scaleAspectFit
        tomatoLogo.image = UIImage(named: "tomatoicon")
        view.addSubview(tomatoLogo)
        
        //emailLabel = UILabel()
        //emailLabel.text = "Email:"
        //emailLabel.textColor = UIColor.black
        //emailLabel.textAlignment = NSTextAlignment.left
        //emailLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        //emailLabel.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(emailLabel)
        
        //emailField = UITextField()
        //emailField.text = "Enter your Email"
        //emailField.textColor = UIColor.black
        //emailField.textAlignment = NSTextAlignment.left
        //emailField.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        //emailField.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(emailField)
        
        //passwordLabel = UILabel()
        //passwordLabel.text = "Password:"
        //passwordLabel.textColor = UIColor.black
        //passwordLabel.textAlignment = NSTextAlignment.left
        //passwordLabel.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        //passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(passwordLabel)
        
        //passwordField = UITextField()
        //passwordField.text = "Enter your Password"
        //passwordField.textColor = UIColor.black
        //passwordField.textAlignment = NSTextAlignment.left
        //passwordField.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        //passwordField.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(passwordField)
        
        buttonBox = UIView()
        view.addSubview(buttonBox)
        
        loginButton = GIDSignInButton()
        buttonBox.addSubview(loginButton)

        
        //signUpButton = UIButton()
       // signUpButton.setTitle("Sign Up", for: .normal)
       // signUpButton.setTitleColor(.black, for: .normal)
       // signUpButton.translatesAutoresizingMaskIntoConstraints = false
        //signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
      //  view.addSubview(signUpButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tomatoLogo.heightAnchor.constraint(equalToConstant: 200),
            tomatoLogo.widthAnchor.constraint(equalToConstant: 220),
            tomatoLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            tomatoLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.topAnchor.constraint(equalTo: tomatoLogo.bottomAnchor, constant: 26),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            buttonBox.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 115),
            buttonBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBox.heightAnchor.constraint(equalToConstant: 51),
            buttonBox.widthAnchor.constraint(equalToConstant: 220)
        ])
              
//              // *joinButton
        //NSLayoutConstraint.activate([
           // signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
        //    signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
       // ])
    }
    
    @objc func didSignIn()  {

        // Add your code here to push the new view controller
      navigationController?.pushViewController(CreateOrJoinViewController(), animated: true)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // added this is order to continue setting up the ViewControllers for the rest of the app
    // you can change the name and content but make sure to somehow keep the ability to push
    // a new CreateOrJoinViewController onto the stack
    // - Katie
    @objc func testLogin() {
        let newViewController = CreateOrJoinViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }

}
