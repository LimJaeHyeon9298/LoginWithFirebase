//
//  EnterEmailViewController.swift
//  LoginWithFireBase
//
//  Created by 임재현 on 2023/08/31.
//

import UIKit
import SnapKit
import FirebaseAuth

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
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        nextButton.isEnabled = false
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    
}

extension EnterEmailViewController {
    func setUp() {
        
        view.backgroundColor = .black
        
        view.addSubview(stackVeiw)
        
        stackVeiw.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(200)
            
        }
        
        [emailLabel,emailTextField,passwordLabel,passwordTextField,errorLabel].forEach {
            
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
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(stackVeiw).inset(20)
            
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(stackVeiw.snp.bottom).offset(30)
            $0.centerX.equalTo(stackVeiw)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            
        }
        
        
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                self.errorLabel.text = error.localizedDescription
            } else {
                let vc = MainViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    @objc func tapNextButton() {
        //Firebase 이메일, 비밀번호 인증
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorLabel.text = error.localizedDescription
                }
            } else {
                let vc = MainViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
       
        
        
    }
    
    
}

extension EnterEmailViewController: UITextFieldDelegate {
   
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Allow the text change
           return true
       }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
        
      
    }
    
    
    
}
