//
//  DetailsTableViewCell.swift
//  TVShows
//
//  Created by Vladyslav Kolomiiets on 28.06.2020.
//  Copyright © 2020 Vladyslav Kolomiiets. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!
    
    func configureCell(with text: String) {
        label.text = text
    }
}
