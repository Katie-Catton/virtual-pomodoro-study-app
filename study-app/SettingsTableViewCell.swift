//
//  SettingsTableViewCell.swift
//  study-app
//
//  Created by Katie Catton on 12/8/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // name of setting
    var nameLabel: UILabel!
    // textfield that allows user to enter numeric values
    var numericInput: UITextField!
    // switch that allows user to toggle the muting function
    var toggleMute: UISwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        numericInput = UITextField()
        numericInput.translatesAutoresizingMaskIntoConstraints = false
        numericInput.attributedPlaceholder = NSAttributedString(string: "00:00:00", attributes: [.foregroundColor: UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0), .font: UIFont(name: "HelveticaNeue-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)])
        numericInput.textAlignment = .center
        numericInput.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        numericInput.textColor = .black
        numericInput.layer.borderWidth = 1
        numericInput.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        numericInput.layer.cornerRadius = 10
        
        toggleMute = UISwitch()
        toggleMute.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(for setting: Setting) {
        nameLabel.text = setting.title
        selectTypeOfInput(setting: setting)
    }
    
    func selectTypeOfInput(setting: Setting) {
        if setting.type == .input {
            contentView.addSubview(numericInput)
            
            NSLayoutConstraint.activate([
                numericInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                numericInput.heightAnchor.constraint(equalToConstant: 46),
                numericInput.widthAnchor.constraint(equalToConstant: 143),
                numericInput.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
            ])
        }
        else {
            contentView.addSubview(toggleMute)
            
            NSLayoutConstraint.activate([
                toggleMute.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                toggleMute.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
            ])
        }
    }

}
