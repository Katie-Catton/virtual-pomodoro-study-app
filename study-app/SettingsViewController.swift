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
    
    // data for table
    let reuseIdentifier = "settingCellReuse"
    
    let workDuration = Setting(title: "Work Session", type: .inputTime)
    let breakDuration = Setting(title: "Break Session", type: .inputTime)
    let numberOfSessions = Setting(title: "Number of Sessions", type: .inputNumSessions)
    let optionalMute = Setting(title: "Let users unmute", type: .toggle)
    
    var settings: [Setting]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = [workDuration, breakDuration, numberOfSessions, optionalMute]
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
    }
    
    func setupConstraints() {
        // *settingsTable
        NSLayoutConstraint.activate([
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            settingsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
    // TODO: implement didSelectRowAt?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
