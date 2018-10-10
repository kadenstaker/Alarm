//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Kaden Staker on 10/8/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    weak var delegate: AlarmTableViewCellDelegate?
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    func updateViews() {
        guard let alarm = alarm else { return }
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchValueChanged(cell: self)
    }
}
