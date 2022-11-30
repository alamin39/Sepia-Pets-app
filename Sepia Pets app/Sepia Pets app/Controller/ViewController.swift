//
//  ViewController.swift
//  Sepia Pets app
//
//  Created by Al-Amin on 30/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var petList: UITableView!
    
    private var allPetInfo = [Pets]()
    private let cellIdentifier = "cell"
    private let xibIdentifier = "PetsInfoCell"
    private let cellHeight = 150.0
    private let appTitle = "Sepia Pets"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = appTitle
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        petList.delegate = self
        petList.dataSource = self
        petList.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        petList.tableFooterView = UIView()
    }
    
    private func fetchData() {
        allPetInfo = NetworkManager().loadPetInfoFromJson(filename: "pets_list") ?? []
        DispatchQueue.main.async {
            self.petList.reloadData()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "No Access!", message: "Sorry, You can't access in non-working hours.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func canAccess() -> Bool {
        let today = Date()
        let hours = Calendar.current.component(.hour, from: today)
        let minutes = Calendar.current.component(.minute, from: today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayInWeek = dateFormatter.string(from: today)
        
        if (dayInWeek == "Sat" || dayInWeek == "Sun") {
            return false
        }
        else if (hours < 9 || hours > 18) {
            return false
        }
        else if (hours == 18 && minutes > 0) {
            return false
        }
        else {
            return true
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPetInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PetsInfoCell
        cell.petsName.text = allPetInfo[indexPath.row].title
        let url = URL(string: allPetInfo[indexPath.row].image_url)
        if let url = url {
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                cell.petsImage.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (canAccess() == false) {
            showAlert()
        }
        else {
            UIApplication.shared.open(URL(string: allPetInfo[indexPath.row].content_url)!)
        }
    }
}
