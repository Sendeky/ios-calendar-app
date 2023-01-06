//
//  EditVC.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 1/2/23.
//

import Foundation
import UIKit

class EditVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let yearTextField = UITextField()
    let yearPicker = UIPickerView()
    let nameTextField = UITextField()
    let saveButton = UIButton()
    
    let monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let dayList = Array(1...31)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        view.backgroundColor = .systemBackground
        style()
        layout()
    }
    
    func style() {
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.placeholder = "Month & Day"
        yearTextField.backgroundColor = .orange
        yearTextField.isUserInteractionEnabled = false
        yearTextField.font = .preferredFont(forTextStyle: .title3)
        yearTextField.textAlignment = .center
        yearTextField.layer.cornerRadius = 15
        yearTextField.layer.cornerCurve = .continuous
        yearTextField.layer.borderWidth = 3
        yearTextField.layer.borderColor = CGColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        yearPicker.translatesAutoresizingMaskIntoConstraints = false
        yearPicker.layer.backgroundColor = CGColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        yearPicker.layer.cornerRadius = 15
        yearPicker.layer.cornerCurve = .continuous
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = .orange
        nameTextField.font = .preferredFont(forTextStyle: .title3)
        nameTextField.textAlignment = .center
        nameTextField.layer.cornerRadius = 15
        nameTextField.layer.cornerCurve = .continuous
        nameTextField.layer.borderWidth = 3
        nameTextField.layer.borderColor = CGColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(saveTapped))
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        saveButton.layer.backgroundColor = CGColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        saveButton.layer.cornerRadius = 15
        saveButton.layer.cornerCurve = .continuous
        saveButton.layer.borderWidth = 3
        saveButton.layer.borderColor = CGColor(red: 255.0/255.0, green: 115.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        saveButton.addGestureRecognizer(saveGesture)
    }
    
    func layout() {
        view.addSubview(yearPicker)
        view.addSubview(yearTextField)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            yearTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            yearTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yearTextField.heightAnchor.constraint(equalToConstant: view.bounds.height / 14),
            
            yearPicker.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: -30),
            yearPicker.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),
            yearPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: yearPicker.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: view.bounds.height / 14),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return monthList.count
        } else {
            return dayList.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(monthList[row])"
        } else {
            return "\(dayList[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        yearTextField.text = "\(monthList[row]) \(dayList[row])"

        let row0 = pickerView.selectedRow(inComponent: 0)
        let row1 = pickerView.selectedRow(inComponent: 1)
        
        yearTextField.text = "\(monthList[row0]) \(dayList[row1])"
    }
    
    @objc func saveTapped() {
        //use PUT to upload data
        saveButton.showAnimation {
            print("saveTapped")
            //use PUT to upload data
            
            
            if let date = self.yearTextField.text { //unwraps date
                if date != ""{  //checks empty date
                    if let name = self.nameTextField.text { //unwraps name
                        if name != "" { //checks empty name
                            var eventData : [String : Any] = [
                                "name":"\(name)",
                                "date":"\(date)"
                            ]
                            print(date)
                            print(name)
                            print(eventData)
                            do {
                                if let jsonData = try JSONSerialization.data(withJSONObject: eventData) as? Data
                                {
                                    // Check if everything went well
                                    print(NSString(data: jsonData, encoding: 1)!)
                                    
                                    // Do something cool with the new JSON data
                                }
                            } catch {
                                print("JSONSerialization error", error)
                            }
                        } else {
                            print("CHOOSE NAME")
                            self.nameTextField.attributedPlaceholder = NSAttributedString(
                                string: "CHOOSE NAME",
                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                            )
                            self.saveButton.titleLabel?.textColor = .red
                        }
                    }
                } else {
                    //Puts red placeholder in yearTextField
                    self.yearTextField.attributedPlaceholder = NSAttributedString(
                        string: "CHOOSE DATE",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                    )
                    self.saveButton.titleLabel?.textColor = .red
                }
            }// Checks if yearTextField is empty
        }// Creates json to send
    }// saveTapped func
    
}
