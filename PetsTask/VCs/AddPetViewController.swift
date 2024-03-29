//
//  AddPetViewController.swift
//  PetsTask
//
//  Created by yousef mandani on 04/03/2024.
//

import UIKit
import SnapKit

class AddPetViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let ageTextField = UITextField()
    private let genderTextField = UITextField()
    private let imageTextField = UITextField()
    private let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubviews()
        setupUI()
        setupLayout()
    }
    
    func addSubviews(){
        view.addSubview(imageTextField)
        view.addSubview(nameTextField)
        view.addSubview(ageTextField)
        view.addSubview(genderTextField)
        view.addSubview(sendButton)
    }
    func setupUI(){
        view.backgroundColor = .white
        
        nameTextField.placeholder = "name"
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 5
        nameTextField.borderStyle = .roundedRect
        
        ageTextField.placeholder = "age"
        ageTextField.layer.borderWidth = 1
        ageTextField.layer.cornerRadius = 5
        ageTextField.borderStyle = .roundedRect
        
        genderTextField.placeholder = "gender"
        genderTextField.layer.borderWidth = 1
        genderTextField.layer.cornerRadius = 5
        genderTextField.borderStyle = .roundedRect
        
        imageTextField.placeholder = "image"
        imageTextField.layer.borderWidth = 1
        imageTextField.layer.cornerRadius = 5
        imageTextField.borderStyle = .roundedRect
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.layer.cornerRadius = 10
        sendButton.backgroundColor = .systemBlue
        sendButton.addTarget(self, action: #selector(sendButtonPress), for: .touchUpInside)
    }
    func setupLayout(){
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.width.equalTo(200)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        imageTextField.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(imageTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
    }
    
    @objc func sendButtonPress(){
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "")
        let gender = genderTextField.text ?? ""
        let image = imageTextField.text ?? ""
        
        let pet = Pet(id: nil, name: name, adopted: false, image: image, age: age ?? 0, gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    print("success")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("failed")
                }
            }
        }
    }
}
