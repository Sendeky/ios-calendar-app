//
//  VideoListVC.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 11/19/22.
//

import UIKit
import SwiftyJSON

class VideoListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        
        let token = Constants.token
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
        
        //Adds refresh control
        tableView.refreshControl = refreshControl
        
        setTableViewDelegates()
        //cell row height
        tableView.rowHeight = 80
        //register cells
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
        //set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
    
    @objc func switchChanged(_ sender : UISwitch!){

          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
    func setTableViewDelegates() {
        tableView.delegate = self       //signs up videoListVC to be delegate and datasource
        tableView.dataSource = self
    }

}
