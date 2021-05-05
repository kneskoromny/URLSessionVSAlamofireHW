//
//  JokeTableViewCell.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import UIKit

class JokeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configureCell(with joke: Joke) {
        titleLabel.text = joke.setup
        detailLabel.text = joke.punchline
    }

}
