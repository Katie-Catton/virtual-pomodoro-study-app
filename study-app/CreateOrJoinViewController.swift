//
//  CreateOrJoinViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/6/20.
//
import UIKit

class CreateOrJoinViewController: UIViewController {
    
    // app icon
    var tomatoImage: UIImageView!
    // welcome text
    var welcomeLabel: UILabel!
    // messgae that provides basic instructions for user to create or join a session
    var instructionText: UITextView!
    // button to create a session
    var createButton: UIButton!
    // separates create/join options
    var separateButtonText: UILabel!
    // button to join a session
    var joinButton: UIButton!
    // field to input a "room code" to join a session
    var inputCode: UITextField!
    // error message if room code is incorrect
    var incorrectLabel: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        // *tomatoImage
        tomatoImage = UIImageView()
        tomatoImage.translatesAutoresizingMaskIntoConstraints = false
        tomatoImage.contentMode = .scaleAspectFit
        tomatoImage.image = UIImage(named: "tomatoicon")
        view.addSubview(tomatoImage)
        
        // *welcomeLabel
        // TODO pass user's name as parameter to createWelcomeLabel()
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.attributedText = createWelcomeLabel()
        welcomeLabel.textColor = .black
        view.addSubview(welcomeLabel)
        
        // *instructionText
        instructionText = UITextView()
        instructionText.translatesAutoresizingMaskIntoConstraints = false
        instructionText.text = "To start, select an option below."
        instructionText.textColor = .black
        instructionText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        instructionText.isScrollEnabled = false
        instructionText.isEditable = false
        view.addSubview(instructionText)
        
        // *createButton
        createButton = UIButton(type: UIButton.ButtonType.system)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create Meeting", for: .normal)
        createButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        createButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        createButton.backgroundColor = .white
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        // shadow underneath button
        createButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        createButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        createButton.layer.shadowOpacity = 0.25
        createButton.layer.shadowRadius = 0
        createButton.layer.masksToBounds = false
        createButton.layer.cornerRadius = 29
        createButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 39, bottom: 16, right: 39)
        createButton.addTarget(self, action: #selector(pushSettings), for: .touchUpInside)
        view.addSubview(createButton)
        
        // *separateButtonText
        separateButtonText = UILabel()
        separateButtonText.translatesAutoresizingMaskIntoConstraints = false
        separateButtonText.text = "- OR -"
        separateButtonText.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        separateButtonText.textColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0)
        view.addSubview(separateButtonText)
        
        // *joinButton
        joinButton = UIButton(type: UIButton.ButtonType.system)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.setTitle("Join Meeting", for: .normal)
        joinButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        joinButton.backgroundColor = .white
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        // shadow underneath button
        joinButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        joinButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        joinButton.layer.shadowOpacity = 0.25
        joinButton.layer.shadowRadius = 0
        joinButton.layer.masksToBounds = false
        joinButton.layer.cornerRadius = 29
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 47, bottom: 16, right: 47)
        joinButton.addTarget(self, action: #selector(pushConference), for: .touchUpInside)
        view.addSubview(joinButton)
        
        // *inputCode
        inputCode = UITextField()
        inputCode.translatesAutoresizingMaskIntoConstraints = false
        // TODO make sure the force unwrapped font attribute make sense
        inputCode.attributedPlaceholder = NSAttributedString(string: "Enter room code here", attributes: [.foregroundColor: UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0), .font: UIFont(name: "HelveticaNeue-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)])
        inputCode.textAlignment = .center
        inputCode.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        inputCode.textColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0)
        inputCode.layer.borderWidth = 1
        inputCode.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        inputCode.layer.cornerRadius = 10
        view.addSubview(inputCode)
        
        // TODO
        // *incorrectLabel
        incorrectLabel = UITextView()
        incorrectLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectLabel.text = "Incorrect room code.\nPlease try again."
        incorrectLabel.textColor = .black
        incorrectLabel.isScrollEnabled = false
        incorrectLabel.isEditable = false
        incorrectLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    func createWelcomeLabel()-> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Welcome, ", attributes: [.font: UIFont(name: "HelveticaNeue-Light", size: 30.0) ?? UIFont.systemFont(ofSize: 30)])
        let nameAttributedString = NSMutableAttributedString(string: "Michael!", attributes: [.font: UIFont(name: "HelveticaNeue-Bold", size: 30.0) ?? UIFont.systemFont(ofSize: 30)])
        attributedString.append(nameAttributedString)
        return attributedString
    }
    
    func setupConstraints() {
        // *tomatoImage
        NSLayoutConstraint.activate([
            tomatoImage.heightAnchor.constraint(equalToConstant: 200),
            tomatoImage.widthAnchor.constraint(equalToConstant: 220),
            tomatoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            tomatoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *welcomeLabel
        NSLayoutConstraint.activate([
            welcomeLabel.heightAnchor.constraint(equalToConstant: 35),
            welcomeLabel.topAnchor.constraint(equalTo: tomatoImage.bottomAnchor, constant: 48),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *instructionText
        NSLayoutConstraint.activate([
            instructionText.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 3),
            instructionText.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor)
        ])
        
        // *createButton
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 24),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *separateButtonText
        NSLayoutConstraint.activate([
            separateButtonText.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 27),
            separateButtonText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *inputCode
        NSLayoutConstraint.activate([
            inputCode.topAnchor.constraint(equalTo: separateButtonText.bottomAnchor, constant: 27),
            inputCode.heightAnchor.constraint(equalToConstant: 58),
            // TODO make sure box does not resize when typing
            inputCode.widthAnchor.constraint(equalTo: createButton.widthAnchor, constant: -10),
            inputCode.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // *joinButton
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: inputCode.bottomAnchor, constant: 16),
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
        let newViewController = SettingsViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // TODO implement this method
    //
    @objc func pushConference() {
        // if room code is input correctly, present final screen (helper method)?
    }
}
