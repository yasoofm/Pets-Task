//
//  DetailViewController.swift
//  PetsTask
//
//  Created by yousef mandani on 04/03/2024.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let ageLabel = UILabel()
    private let adoptedLabel = UILabel()
    private let genderLabel = UILabel()
    private let imageview = UIImageView()
    
    var pet: Pet?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubviews()
        setupUI()
        setupLayout()
    }
 
    func addSubviews(){
        view.addSubview(imageview)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(adoptedLabel)
        view.addSubview(genderLabel)
    }
    func setupUI(){
        view.backgroundColor = .white
        
        nameLabel.text = "Name: \(pet?.name ?? "")"
        ageLabel.text = String(pet?.age ?? 0)
        adoptedLabel.text = "\(pet?.adopted ?? false)"
        genderLabel.text = pet?.gender
        
        imageview.kf.setImage(with: URL(string: pet?.image ?? ""))
        imageview.contentMode = .scaleToFill
        imageview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        imageview.layer.shadowOffset = CGSize(width: 1, height: 9)
        imageview.layer.shadowOpacity = 2
        imageview.layer.shadowRadius = 9
        imageview.layer.masksToBounds = false
        imageview.layer.cornerRadius = 4
    }
    func setupLayout(){
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        adoptedLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
        }
        genderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(adoptedLabel.snp.bottom).offset(10)
        }
        imageview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
}
