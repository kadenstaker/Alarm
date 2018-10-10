//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Kaden Staker on 10/8/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm? {
        didSet {
            super.loadViewIfNeeded()
            updateViews()
        }
    }

    var alarmIsOn: Bool = true
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var alarmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        alarmDatePicker.setValue(#colorLiteral(red: 0.5202203989, green: 0.4715664983, blue: 0.3232034445, alpha: 1), forKey: "textColor")
    }
    
    private func updateViews() {
        guard let alarm = alarm else { return }
        alarmDatePicker.date = alarm.fireDate
        alarmTextField.text = alarm.name
        alarmIsOn = alarm.enabled
        setUpButton()
    }
    
    func setUpButton() {
        if alarmIsOn {
            alarmButton.backgroundColor = #colorLiteral(red: 0.1779929698, green: 0.1744998693, blue: 0.2444885373, alpha: 1)
            alarmButton.setTitleColor(#colorLiteral(red: 0.9669197202, green: 0.9527007937, blue: 0.9439633489, alpha: 1), for: .normal)
            alarmButton.setTitle("Enabled", for: .normal)
        } else {
            alarmButton.backgroundColor = #colorLiteral(red: 0.5202203989, green: 0.4715664983, blue: 0.3232034445, alpha: 1)
            alarmButton.setTitleColor(#colorLiteral(red: 0.9669197202, green: 0.9527007937, blue: 0.9439633489, alpha: 1), for: .normal)
            alarmButton.setTitle("Disabled", for: .normal)
        }
    }

    @IBAction func enableButtonTapped(_ sender: Any) {
        if let alarm = alarm {
        AlarmController.shared.toggleEnabled(for: alarm)
        alarmIsOn = alarm.enabled
        } else {
            alarmIsOn = !alarmIsOn
        }
        setUpButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alarmTextField.text else { return }
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: alarmDatePicker.date, name: name, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(firedate: alarmDatePicker.date, name: name, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
