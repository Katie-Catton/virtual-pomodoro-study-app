
//  MeetingViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/9/20.
//
import UIKit

class MeetingViewController: UIViewController {
    
    var time = 0 //pull from settings
    var timer = Timer()
    var countDownLabel: UILabel!
    var clockLogo: UIImageView!
    var startTimerButton: UIButton!
    var timeRemaining: UILabel!
    var inProgress: UILabel!
    var inviteCodeText: UILabel!
    var inviteCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        getRooms()
    }
    
    
//    private func startTimer() {
//        self.totalTime = 0
//    }
    
    func setupViews() {
        
        clockLogo = UIImageView()
        clockLogo.translatesAutoresizingMaskIntoConstraints = false
        clockLogo.contentMode = .scaleAspectFit
        clockLogo.image = UIImage(named: "clock")
        view.addSubview(clockLogo)
        
        timeRemaining = UILabel()
        timeRemaining.text = "Time remaining:"
        timeRemaining.textColor = UIColor.black
        timeRemaining.textAlignment = NSTextAlignment.center
        timeRemaining.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        timeRemaining.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeRemaining)
        
        inProgress = UILabel()
        inProgress.text = "In Progress"
        inProgress.textColor = UIColor.black
        inProgress.textAlignment = NSTextAlignment.center
        inProgress.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        inProgress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inProgress)
        
        inviteCodeText = UILabel()
        inviteCodeText.text = "Invite Code"
        inviteCodeText.textColor = UIColor.black
        inviteCodeText.textAlignment = NSTextAlignment.center
        inviteCodeText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        inviteCodeText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inviteCodeText)
        
        
        inviteCode = UITextField()
        inviteCode.text = ""//pull from settings
        inviteCode.isUserInteractionEnabled = false
        inviteCode.layer.cornerRadius = 10.0
        inviteCode.clipsToBounds = true
        inviteCode.textColor = UIColor.black
        inviteCode.textAlignment = NSTextAlignment.center
        inviteCode.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        inviteCode.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inviteCode)
        
    
    }
    
    func setupConstraints() {
    }
    
//    func startTimerButtonPress(sender: startTimerButton) {
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
//    }
//    func pauseTimerButtonPress(sender: pauseTimerButton) {
//        timer.invalidate()
//        }
        
        
    func update() {
        
        if(time > 0){
            let minutes = String(time / 60)
            let seconds = String(time % 60)
            countDownLabel.text = minutes + ":" + seconds
            time -= 1
        }
        else {
            //launch Times Up screen
        }
    }
    
    // Networking stuff
    
    func getRooms() {
        NetworkManager.getRooms()
    }
    
}
