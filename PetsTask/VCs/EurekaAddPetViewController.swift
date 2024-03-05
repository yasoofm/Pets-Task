//
//  EurekaAddPetViewController.swift
//  PetsTask
//
//  Created by yousef mandani on 05/03/2024.
//

import UIKit
import Eureka

class EurekaAddPetViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        form +++ Section("Pet information")
        <<< TextRow{ row in
            row.title = "Name"
            row.placeholder = "Enter pet name"
            row.tag = "\(Tag.name)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< IntRow{ row in
            row.title = "Age"
            row.placeholder = "Enter pet age"
            row.tag = "\(Tag.age)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow{ row in
            row.title = "Gender"
            row.placeholder = "Enter pet gender"
            row.tag = "\(Tag.gender)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< CheckRow{ row in
            row.title = "Adopted"
            row.tag = "\(Tag.adopted)"
        }
        <<< TextRow{ row in
            row.title = "Image"
            row.placeholder = "Enter pet image"
            row.tag = "\(Tag.image)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        form +++ Section()
        <<< ButtonRow{ row in
            row.title = "Send"
            row.onCellSelection { cell, row in
                print("pressed")
                self.submitForm()
            }
        }
    }
    
    @objc func submitForm(){
        
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: "\(Tag.name)")
        let ageRow: IntRow? = form.rowBy(tag: "\(Tag.age)")
        let genderRow: TextRow? = form.rowBy(tag: "\(Tag.gender)")
        let adoptedRow: CheckRow? = form.rowBy(tag: "\(Tag.adopted)")
        let imageRow: TextRow? = form.rowBy(tag: "\(Tag.image)")
        
        let name = nameRow?.value ?? ""
        let age = ageRow?.value ?? 0
        let gender = genderRow?.value ?? ""
        let adopted = adoptedRow?.value ?? false
        let image = imageRow?.value ?? ""
        
        let pet = Pet(name: name, adopted: adopted, image: image, age: age, gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success{
                    self.navigationController?.popViewController(animated: true)                }
            }
        }
    }
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
