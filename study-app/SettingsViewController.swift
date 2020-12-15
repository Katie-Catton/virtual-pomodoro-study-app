//
//  SettingsViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/8/20.
//

import UIKit

class SettingsViewController: UIViewController {

    // scrollable view containing all settings options
    var settingsTable: UITableView!
    // button to start a meeting
    var startButton: UIButton!
    
    // data for table
    let reuseIdentifier = "settingCellReuse"
    
    let workDuration = Setting(title: "Work Session", text: "00:25:00", type: .input)
    let breakDuration = Setting(title: "Break Session", text: "00:05:00", type: .input)
    let numberOfSessions = Setting(title: "Number of Sessions", text: "4", type: .input)
    let optionalMute = Setting(title: "Other", text: "Let users unmute", type: .toggle)
    let createMeetingCode = Setting(title: "Create room code", text: "bluehats", type: .input)
    
    var settings: [Setting]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = [workDuration, breakDuration, numberOfSessions, optionalMute, createMeetingCode]
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        // *settingsTable
        settingsTable = UITableView()
        settingsTable.translatesAutoresizingMaskIntoConstraints = false
        settingsTable.dataSource = self
        settingsTable.delegate = self
        settingsTable.register(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        settingsTable.separatorStyle = .none
        view.addSubview(settingsTable)
        
        // *startButton
        startButton = UIButton(type: UIButton.ButtonType.system)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start Call", for: .normal)
        startButton.setTitleColor(UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
        startButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        startButton.backgroundColor = .white
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        startButton.layer.shadowColor = UIColor(red: 136/255, green: 134/255, blue: 134/255, alpha: 1.0).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startButton.layer.shadowOpacity = 0.25
        startButton.layer.shadowRadius = 0
        startButton.layer.masksToBounds = false
        startButton.layer.cornerRadius = 29
        startButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 73, bottom: 16, right: 73)
        startButton.addTarget(self, action: #selector(pushMeeting), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    func setupConstraints() {
        // *settingsTable
        NSLayoutConstraint.activate([
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            settingsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        // *startButton
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: settingsTable.bottomAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func pushMeeting() {
        let newViewController = MeetingViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        let setting = settings[indexPath.row]
        cell.configure(for: setting)
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
