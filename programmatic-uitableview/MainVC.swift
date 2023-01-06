//
//  MainVC.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 11/19/22.
//

import UIKit
import SwiftyJSON

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let addButton = UIButton()
    var tableView = UITableView()
    var settings: [Settings] = []
    private var refreshControl = UIRefreshControl()
    
    var apiResult = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        title = "Birthdays"
//        settings = makeSettingsCells()
        configureTableView()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        print("pull to refresh")
        
        let token = Constants.token //uses token from Constants file
        let urlString = "https://bday-368509.wl.r.appspot.com/dates?token=\(token)"
        
        
        //------------------------------------------------
        DispatchQueue.global().async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.apiResult = JSON(data)
                    
                    print(self.apiResult)
                    self.settings = self.makeSettingsCells()
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }

        }
        //------------------------------------------------
        
        
        refreshControl.endRefreshing()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        addButton.backgroundColor = .orange
        addButton.layer.backgroundColor = CGColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        addButton.layer.cornerRadius = 15
        addButton.layer.cornerCurve = .continuous
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = CGColor(red: 255.0/255.0, green: 115.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        setTableViewDelegates()
        tableView.rowHeight = 60
        //register cells
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    //which cell was clicked
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsCell       //Casts as SettingsCell because we want the funcs inside SettingsCell
        
        //adds switch to cell
//        let switchView = UISwitch(frame: .zero)
//        switchView.setOn(false, animated: true)
//        switchView.tag = indexPath.row // for detect which row switch Changed
//        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
//        cell.accessoryView = switchView
        
        let setting = settings[indexPath.row]           //indexPath will have 3
        cell.set(settings: setting)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            settings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//            settings.append(Settings(image: UIImage(systemName: "sun.max.fill")!, date: "0.9.21", body: "body"))
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!){

          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
    func setTableViewDelegates() {
        tableView.delegate = self       //signs up videoListVC to be delegate and datasource
        tableView.dataSource = self
    }

}
