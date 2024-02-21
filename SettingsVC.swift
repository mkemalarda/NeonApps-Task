//
//  SettingsVC.swift
//  InstagramTask
//
//  Created by Mustafa Kemal ARDA on 16.02.2024.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        
        createUI()
        
    }
    
    
    func createUI(){
        let titleLabel = UILabel()
        titleLabel.text = "Settings Screen"
        titleLabel.textAlignment = .center
        //   titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .systemBlue
        titleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        let signOutButton = UIButton()
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = .systemBlue
        signOutButton.layer.cornerRadius = 15
        signOutButton.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
        
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
        }
        
    }
    
    @objc func clickedButton(){
        
        do {
            try Auth.auth().signOut()
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } catch {
            print("error")
        }
        
        
    }
    
    
    
}


//#Preview(body: {
//    SettingsVC()
//})

