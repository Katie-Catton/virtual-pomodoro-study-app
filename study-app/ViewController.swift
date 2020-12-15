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
    var tomatoLogo: UIImageView!
    var loginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupNavigationBar()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn(_:)), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
    }
    
    // modifies default navigation bar
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.navigationBar.topItem?.title = " "
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
        
        loginButton = GIDSignInButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
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
            loginButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 115),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didSignIn(_ sender: GIDSignIn)  {
        let newViewController = CreateOrJoinViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
