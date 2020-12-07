//
//  CreateOrJoinViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/6/20.
//

import UIKit

class CreateOrJoinViewController: UIViewController {
    
    // standard welcome text for all users
    var welcomeLabel: UILabel!
    // name of user to personalize user experience
    var userNameLabel: UILabel!
    // messgae that provides basic instructions for user to create or join a session
    var instructionText: UITextView!
    // button to create a session
    var createButton: UIButton!
    // button to join a session
    var joinButton: UIButton!
    // field to input a "room code" to join a session
    var inputCode: UITextField!
    // error message if room code is incorrect
    var incorrectLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        // *welcomeLabel
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome, "
        welcomeLabel.textColor = .black
        welcomeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        view.addSubview(welcomeLabel)
        
        // *userNameLabel
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        // TODO: text needs to match user's name on account
        userNameLabel.text = "Michael!"
        userNameLabel.textColor = .black
        userNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        view.addSubview(userNameLabel)
        
        // *instructionText
        instructionText = UITextView()
        instructionText.translatesAutoresizingMaskIntoConstraints = false
        instructionText.text = "To start, select an option below for your work session."
        instructionText.textColor = .black
        instructionText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        view.addSubview(instructionText)
        
        // *createButton
        createButton = UIButton(type: UIButton.ButtonType.system)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        createButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        createButton.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        // shadow underneath button
        createButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        createButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        createButton.layer.shadowOpacity = 0.5
        createButton.layer.shadowRadius = 0
        createButton.layer.masksToBounds = false
        createButton.layer.cornerRadius = 29
        createButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 88, bottom: 16, right: 88)
        createButton.addTarget(self, action: #selector(pushSettings), for: .touchUpInside)
        view.addSubview(createButton)
        
        // *joinButton
        joinButton = UIButton(type: UIButton.ButtonType.system)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.setTitle("Join", for: .normal)
        joinButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        joinButton.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        // shadow underneath button
        joinButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        joinButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        joinButton.layer.shadowOpacity = 0.5
        joinButton.layer.shadowRadius = 0
        joinButton.layer.masksToBounds = false
        joinButton.layer.cornerRadius = 29
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 100, bottom: 16, right: 100)
        joinButton.addTarget(self, action: #selector(showInputCode), for: .touchUpInside)
        view.addSubview(joinButton)
        
        // *inputCode
        inputCode = UITextField()
        inputCode.translatesAutoresizingMaskIntoConstraints = false
        // TODO make sure the force unwrapped font attribute make sense
        inputCode.attributedPlaceholder = NSAttributedString(string: "Enter room code here", attributes: [.foregroundColor: UIColor.gray, .font: UIFont(name: "HelveticaNeue-Light", size: 25) ?? UIFont.systemFont(ofSize: 25)])
        inputCode.textAlignment = .center
        inputCode.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        inputCode.textColor = .gray
        inputCode.layer.borderWidth = 1
        inputCode.layer.borderColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        
        // TODO
        // *incorrectLabel
        incorrectLabel = UILabel()
        incorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectLabel.text = "Incorrect room code.\nPlease try again."
        // allows multiple lines
        incorrectLabel.numberOfLines = 0
        incorrectLabel.textColor = .black
        incorrectLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    func setupConstraints() {
        // *welcomeLabel
        NSLayoutConstraint.activate([
            welcomeLabel.heightAnchor.constraint(equalToConstant: 30),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
        // *userNameLabel
        NSLayoutConstraint.activate([
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            userNameLabel.topAnchor.constraint(equalTo: welcomeLabel.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 5)
        ])
        
        // *instructionText
        NSLayoutConstraint.activate([
            instructionText.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 15),
            instructionText.heightAnchor.constraint(equalToConstant: 60),
            instructionText.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            instructionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        // *createButton
        NSLayoutConstraint.activate([
            createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *joinButton
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 14),
            joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *incorrectLabel
//        NSLayoutConstraint.activate([
//            incorrectLabel.topAnchor.constraint(equalTo: inputCode.bottomAnchor, constant: 14),
//            incorrectLabel.leadingAnchor.constraint(equalTo: inputCode.leadingAnchor)
//        ])
    }

    // TODO implement this method
    //
    @objc func pushSettings() {
        
    }
    
    // TODO implement this method
    //
    @objc func showInputCode() {
        view.addSubview(inputCode)
        
        // *inputCode
        NSLayoutConstraint.activate([
            inputCode.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 50),
            inputCode.heightAnchor.constraint(equalToConstant: 50),
            inputCode.widthAnchor.constraint(equalTo: createButton.widthAnchor, constant: 10),
            inputCode.leadingAnchor.constraint(equalTo: createButton.leadingAnchor)
        ])
        
        // if room code is input correctly, present final screen (helper method)?
    }
}
