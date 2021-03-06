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
    // textfield that allows user to customize settings
    var textInput: UITextField!
    // switch that allows user to toggle the muting function
    var toggleMute: UISwitch!
    // text describing the unmute option
    var unmuteLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // *nameLabel
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        // *textInput
        textInput = UITextField()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.textAlignment = .center
        textInput.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        textInput.textColor = .black
        textInput.layer.borderWidth = 1
        textInput.layer.borderColor = UIColor(red: 163/255, green: 161/255, blue: 161/255, alpha: 1.0).cgColor
        textInput.layer.cornerRadius = 10
        textInput.keyboardType = .numberPad
        
        // *toggleMute
        toggleMute = UISwitch()
        toggleMute.translatesAutoresizingMaskIntoConstraints = false
        
        // *unmuteLabel
        unmuteLabel = UILabel()
        unmuteLabel.translatesAutoresizingMaskIntoConstraints = false
        unmuteLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    func configure(for setting: Setting) {
        nameLabel.text = setting.title
        selectTypeOfInput(setting: setting)
    }
    
    func selectTypeOfInput(setting: Setting) {
        if setting.type != .toggle{
            // *textInput
            textInput.attributedPlaceholder = NSAttributedString(string: setting.placeholderText, attributes: [.foregroundColor: UIColor.black, .font: UIFont(name: "HelveticaNeue-Light", size: 24)!])
            contentView.addSubview(textInput)
            
            NSLayoutConstraint.activate([
                textInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                textInput.heightAnchor.constraint(equalToConstant: 46),
                textInput.widthAnchor.constraint(equalToConstant: 143),
                textInput.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
            ])
        }
        else {
            // *toggleMute and *unmuteLabel
            unmuteLabel.text = setting.placeholderText
            contentView.addSubview(unmuteLabel)
            contentView.addSubview(toggleMute)
            
            NSLayoutConstraint.activate([
                unmuteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
                unmuteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 68),
                unmuteLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            NSLayoutConstraint.activate([
                toggleMute.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                toggleMute.leadingAnchor.constraint(equalTo: unmuteLabel.trailingAnchor, constant: 20),
            ])
        }
    }

}
