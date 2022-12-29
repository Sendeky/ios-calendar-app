//
//  SettingsCell.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 11/19/22.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var cellImageView = UIImageView()
    var cellDateLabel = UILabel()
    var cellBodyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellImageView)
        addSubview(cellDateLabel)
        addSubview(cellBodyLabel)
        
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(settings: Settings) {
        cellImageView.image = settings.image
        cellDateLabel.text = settings.date
        cellBodyLabel.text = settings.body
    }
    
    func configureImageView() {
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        cellDateLabel.numberOfLines = 0
        cellDateLabel.adjustsFontSizeToFitWidth = true
    }
    func configureBodyLabel() {
        cellBodyLabel.numberOfLines = 0
        cellBodyLabel.adjustsFontSizeToFitWidth = true
        cellBodyLabel.textColor = .systemGray
    }
    
    func layout() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cellBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cellImageView.heightAnchor.constraint(equalToConstant: 60),
            cellImageView.widthAnchor.constraint(equalToConstant: 60),
            
            cellDateLabel.topAnchor.constraint(equalTo: topAnchor),
            cellDateLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            
            cellBodyLabel.topAnchor.constraint(equalTo: cellDateLabel.bottomAnchor, constant: 5),
            cellBodyLabel.leadingAnchor.constraint(equalTo: cellDateLabel.leadingAnchor),
        ])

    }
}

extension VideoListVC {
    
    func makeSettingsCells() -> [Settings] {
        
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM/dd"
        let today = dateformat.string(from: date)
        print(today)
        
        
        var sett = [Settings]()
//        var result = apiResult.object
        for (index, object) in apiResult {
            let name = object["name"].stringValue
            var date = object["date"].stringValue
            let year = object["year"].stringValue
            if date == today {
                date = "** \(date)"
                print(date)
            }
            if year != "" {
                date = "\(date)/\(year)"
            }
            
            print(name)
            sett.append(
                Settings(image: UIImage(systemName: "birthday.cake.fill")!, date: "\(date)", body: "\(name)")
            )
        }
//        apiResult.forEach { res in
////            let d = res["date"].stringValue
////            sett.append(
////                Settings(image: UIImage(systemName: "bell.circle.fill")!, date: , body: <#T##String#>)
////            )
//            print(res)
//        }
        return sett
    }
    
}
