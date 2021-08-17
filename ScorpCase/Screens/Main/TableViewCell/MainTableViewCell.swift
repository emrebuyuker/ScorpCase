//
//  MainTableViewCell.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func mainTableViewCellMethod(name: String, id: String) {
        self.titleLabel.text = "\(name) (\(id))"
    }
}
