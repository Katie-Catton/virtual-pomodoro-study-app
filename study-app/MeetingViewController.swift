
//  MeetingViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/9/20.
//
import UIKit

//getRooms()


class MeetingViewController: UIViewController {
    
    //private var rooms: Rooms!
    var time: Int = 0 //rooms.workLength    pull from settings
    var timer = Timer()
    var counter: Int = 0
    var status: Bool = true
    var sessions: Int = 4
    var countDownLabel: UILabel!
    
    var startTimerButton: UIButton!
    var timeRemaining: UILabel!
    var inviteCodeText: UILabel!
    var inviteCode: UITextField!
    var editButton: UIButton!
    
//     init(rooms: Rooms) {
//         super.init(nibName: nil, bundle: nil)
//         self.rooms = rooms
//     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        self.navigationController?.navigationBar.topItem?.title = " "

        setupViews()
        setupConstraints()
        //getRooms()
    }
    
    func setupViews() {
        
        timeRemaining = UILabel()
        timeRemaining.text = "Time remaining:"
        timeRemaining.textColor = UIColor.black
        timeRemaining.textAlignment = NSTextAlignment.center
        timeRemaining.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        timeRemaining.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeRemaining)
        
        countDownLabel = UILabel()
        countDownLabel.text = ""
        countDownLabel.textColor = UIColor.black
        countDownLabel.textAlignment = NSTextAlignment.center
        countDownLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        countDownLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countDownLabel)
        
        inviteCodeText = UILabel()
        inviteCodeText.text = "Invite Code"
        inviteCodeText.textColor = UIColor.black
        inviteCodeText.textAlignment = NSTextAlignment.center
        inviteCodeText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        inviteCodeText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inviteCodeText)
        
        inviteCode = UITextField()
        inviteCode.text = "bluehats"//pull from settings
        inviteCode.isUserInteractionEnabled = false
        inviteCode.layer.cornerRadius = 12
        inviteCode.clipsToBounds = true
        inviteCode.textColor = UIColor.black
        inviteCode.textAlignment = NSTextAlignment.center
        inviteCode.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        inviteCode.translatesAutoresizingMaskIntoConstraints = false
        inviteCode.layer.borderWidth = 1
        inviteCode.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        view.addSubview(inviteCode)
        
        startTimerButton = UIButton()
        startTimerButton.setTitle("Start Session", for: .normal)
        startTimerButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        startTimerButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        startTimerButton.backgroundColor = .white
        startTimerButton.layer.borderWidth = 1
        startTimerButton.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        startTimerButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        startTimerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startTimerButton.layer.shadowOpacity = 0.25
        startTimerButton.layer.shadowRadius = 0
        startTimerButton.layer.masksToBounds = false
        startTimerButton.layer.cornerRadius = 20
        startTimerButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        startTimerButton.translatesAutoresizingMaskIntoConstraints = false
        startTimerButton.addTarget(self, action: #selector(startTimerButtonPress), for: .touchUpInside)
        view.addSubview(startTimerButton)
        
        let editImage = UIImage(named: "editicon")
        editButton = UIButton(type: UIButton.ButtonType.system)
        editButton.setBackgroundImage(editImage, for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.backgroundColor = .white
        editButton.addTarget(self, action: #selector(pushSettings), for: .touchUpInside)
        view.addSubview(editButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timeRemaining.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timeRemaining.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            timeRemaining.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            inviteCodeText.leadingAnchor.constraint(equalTo: timeRemaining.leadingAnchor),
            inviteCodeText.heightAnchor.constraint(equalToConstant: 21),
            inviteCodeText.topAnchor.constraint(equalTo: timeRemaining.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            inviteCode.leadingAnchor.constraint(equalTo: inviteCodeText.trailingAnchor, constant: 6),
            inviteCode.heightAnchor.constraint(equalToConstant: 28),
            inviteCode.widthAnchor.constraint(equalToConstant: 82),
            inviteCode.topAnchor.constraint(equalTo: inviteCodeText.topAnchor),
            inviteCode.centerYAnchor.constraint(equalTo: inviteCodeText.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            startTimerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            countDownLabel.topAnchor.constraint(equalTo: timeRemaining.topAnchor),
            countDownLabel.leadingAnchor.constraint(equalTo: timeRemaining.trailingAnchor, constant: 10)
        ])
    }
    
    @objc func startTimerButtonPress() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @objc func pauseTimerButtonPress() {
        timer.invalidate()
    }
    
    // makes timer countdown for work and break sessions
    @objc func update() {

            if(time > 0){
                let minutes = String(time / 60)
                let seconds = String(time % 60)
                countDownLabel.text = minutes + ":" + seconds
                time -= 1
            }
            else if counter < sessions {
                status = !status
                if status == true {
                    time = 1500 //rooms.workLength Placeholder for study time session
                    counter += 1
                    update()
                }
                else {
                    time = 900 //rooms.breakLength Placeholder for break time
                    counter += 1
                    update()
                }

            }
            else {
                let newViewController = SettingsViewController()
                navigationController?.pushViewController(newViewController, animated: true)
                
            }
    }
    
    @objc func pushSettings() {
        let newViewController = SettingsViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // Networking
//    func getRooms() {
//        NetworkManager.getRooms { rooms in
//            self.rooms = rooms
//            DispatchQueue.main.async {
//                self.roomsTableView.reloadData()
//            }
//
//        }
//    }
    
    
}
