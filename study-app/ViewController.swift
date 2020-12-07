//
//  ViewController.swift
//  study-app
//
//  Created by Katie Catton on 12/6/20.
//

import UIKit

class ViewController: UIViewController {

    // temporary button added in order to test create or join screen
    var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testButton = UIButton()
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.setTitle("Login", for: .normal)
        testButton.addTarget(self, action: #selector(pushCreateOrJoin), for: .touchUpInside)
        view.addSubview(testButton)
        
        NSLayoutConstraint.activate([
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func pushCreateOrJoin() {
        let newViewController = CreateOrJoinViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }


}

