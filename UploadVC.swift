//
//  UploadVC.swift
//  InstagramTask
//
//  Created by Mustafa Kemal ARDA on 16.02.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let titleLabel = UILabel()
    let uploadImage = UIImageView()
    let commentTextField = UITextField()
    let uploadButton = UIButton()
    
    var firestorePost: [String : Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        uploadImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImage.addGestureRecognizer(gestureRecognizer)
        
        
        
        createUI()
    }
    
    
    func createUI(){
        titleLabel.text = "Upload Screen"
        titleLabel.textAlignment = .center
        //   titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .systemBlue
        titleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        uploadImage.image = UIImage(named: "selectimage")
        
        view.addSubview(uploadImage)
        uploadImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.width.height.equalTo(250)
        }
        
        commentTextField.placeholder = "comment"
        commentTextField.borderStyle = .roundedRect
        
        view.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(uploadImage.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.backgroundColor = .systemBlue
        uploadButton.layer.cornerRadius = 15
        uploadButton.addTarget(self, action: #selector(uploadButtonClicked), for: .touchUpInside)
        
        view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(commentTextField.snp.bottom).offset(80)
            make.width.equalTo(100)
        }
        
        
    }
    
    // galeriye erişim
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    // galerideki fotoyu uygulamaya aktarır
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImage.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func uploadButtonClicked(){
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadImage.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data,metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            
                            
                            //MARK: - DATABASE
                            
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            self.firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentTextField.text, "date": FieldValue.serverTimestamp(), "like" : 0 ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: self.firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                                } else {
                                    self.uploadImage.image = UIImage(named: "selectimage")
                                    self.commentTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })                            
                        }
                    }
                }
            }
        }
    }
    
}

//#Preview(body: {
//    UploadVC()
//})

