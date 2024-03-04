//
//  ViewController.swift
//  PetsTask
//
//  Created by yousef mandani on 04/03/2024.
//

import UIKit

class TableViewController: UITableViewController {

    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchPets()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(navButtonPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reloadButtonPress))
    }
    
    @objc func reloadButtonPress(){
        fetchPets()
        tableView.reloadData()
    }
    
    @objc func navButtonPress(){
        navigationController?.pushViewController(AddPetViewController(), animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.pet = pets[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TableViewController{
    func fetchPets(){
        NetworkManager.shared.fetchPets { pets in
            DispatchQueue.main.async {
                self.pets = pets ?? []
                self.tableView.reloadData()
            }
        }
    }
}
