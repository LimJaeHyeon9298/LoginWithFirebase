//
//  LoginViewController.swift
//  LoginWithFireBase
//
//  Created by 임재현 on 2023/08/31.
//

import UIKit
import SnapKit


class LoginViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    private let musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.house.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요"
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        
        stackView.spacing = 20
        return stackView
    }()
    
   
    private let emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("이메일/비밀번호로 계속하기", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(touchEmailButton), for: .touchUpInside)
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("구글로 계속하기", for: .normal)
        button.backgroundColor = .black
        return button
    }()
   
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple로 계속하기", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }


}

extension LoginViewController {
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(200)
            
        }
        
        [musicImageView,descriptionLabel].forEach {
            stackView.addSubview($0)
        }
        
        musicImageView.snp.makeConstraints {
            $0.centerX.equalTo(stackView)
            $0.width.equalTo(80)
            $0.height.equalTo(70)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(musicImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(stackView)
            $0.leading.trailing.equalTo(stackView).inset(40)
        }
        
        view.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(200)
        }
        
        [emailButton,googleButton,appleButton].forEach {
            buttonStackView.addSubview($0)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.cornerRadius = 20
            
        }
        
        emailButton.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.top).inset(20)
            $0.leading.trailing.equalTo(stackView).inset(20)
            $0.height.equalTo(40)
            
        }
        googleButton.snp.makeConstraints {
            $0.top.equalTo(emailButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(stackView).inset(20)
            $0.height.equalTo(40)
        }
        appleButton.snp.makeConstraints {
            $0.top.equalTo(googleButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(stackView).inset(20)
            $0.height.equalTo(40)
        }
    }
    
    @objc func touchEmailButton() {
        
        let vc = EnterEmailViewController()
        
        navigationController?.pushViewController(vc, animated: false)
      //  present(vc, animated: true)
    }
    
}
