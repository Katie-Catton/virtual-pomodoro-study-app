//
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
    var inviteCode: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    
    private func startTimer() {
        self.totalTime = 0
    }
    
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
        timeRemaining.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        timeRemaining.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeRemaining)
        
        
        
        
    }
    
    func setupConstraints() {
    }
    
    func startTimerButtonPress(sender: startTimerButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
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
    
}
