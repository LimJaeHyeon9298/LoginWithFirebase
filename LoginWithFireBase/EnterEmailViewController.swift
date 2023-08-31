//
//  EnterEmailViewController.swift
//  LoginWithFireBase
//
//  Created by 임재현 on 2023/08/31.
//

import UIKit
import SnapKit

class EnterEmailViewController : UIViewController {
    
    private let stackVeiw: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        
        return stackView
    }()
    
    private let emailLabel:UILabel = {
       let label = UILabel()
        label.text = "이메일 주소가 무엇인가요?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
   
    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        return textField
    }()
    

    private let passwordLabel:UILabel = {
       let label = UILabel()
        label.text = "비밀번호를 입력하세요"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
}

extension EnterEmailViewController {
    func setUp() {
        
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = false
        view.addSubview(stackVeiw)
        
        stackVeiw.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(200)
            
        }
        
        [emailLabel,emailTextField,passwordLabel,passwordTextField].forEach {
            
            stackVeiw.addSubview($0)
            
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(stackVeiw).inset(20)
            $0.leading.equalTo(stackVeiw).inset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(stackVeiw).inset(20)
            $0.height.equalTo(40)
            
        }
      
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalTo(stackVeiw).inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(stackVeiw).inset(20)
            $0.height.equalTo(40)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(stackVeiw.snp.bottom).offset(30)
            $0.centerX.equalTo(stackVeiw)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            
        }
        
        
    }
}
