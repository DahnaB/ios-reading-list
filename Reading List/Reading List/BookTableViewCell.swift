//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dahna on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell{

    var book: Book?
    weak var delegate: BookTableViewCell?

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBAction func checkBoxStatus(_ sender: UIButton) {
        func toggleHasBeenRead(for cell: BookTableViewCell) {
        }
    }
    

    
    private func updateViews() {
        guard let unwrappedBook = book else { return }
        titleTextLabel.text = unwrappedBook.title
        if unwrappedBook.hasBeenRead == false {
            checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
