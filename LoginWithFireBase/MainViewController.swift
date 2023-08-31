//
//  MainViewController.swift
//  LoginWithFireBase
//
//  Created by 임재현 on 2023/08/31.
//

import UIKit
import FirebaseAuth

class MainViewController:UIViewController {
    
    private let welcomeLabel:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "환영합니다"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let logoutButton:  UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
 환영합니다\(email)님
 """
        
    }
    
    
}

extension MainViewController {
   
    func setup() {
        
        view.backgroundColor = .black
        
        [welcomeLabel,logoutButton].forEach {
            view.addSubview($0)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(welcomeLabel)
        }
    }
    
    @objc func tapLogoutButton() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
