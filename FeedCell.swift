//
//  FeedCell.swift
//  InstagramTask
//
//  Created by Mustafa Kemal ARDA on 18.02.2024.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    static let identifier = "FeedCell"
    let userEmailTextField = UITextField()
    let userImage = UIImageView()
    let commentLabel = UILabel()
    let likeLabel = UILabel()
    let likeButton = UIButton()
    let documentIDLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        userEmailTextField.text = "user@gmail.com"
        
            contentView.addSubview(userEmailTextField)
        userEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        documentIDLabel.text = "idLabel"
        documentIDLabel.isHidden = true
        
        contentView.addSubview(documentIDLabel)
        documentIDLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        userImage.image = UIImage(named: "selectimage")
        
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        commentLabel.text = "comment"

        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(50)
            
        }
        
        likeButton.setTitle("Like", for: .normal)
        likeButton.setTitleColor(.systemBlue, for: .normal)
        likeButton.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
        
        contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(50)

        }
        
        likeLabel.text = "0"
        
        contentView.addSubview(likeLabel)
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(50)
            
        }
       
        
        
        

        
    }
    
    @objc func clickedButton(){

        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["like" : likeCount + 1] as [String : Any]
            
            fireStoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)

        }
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


//#Preview(body: {
//    FeedCell()
//})

