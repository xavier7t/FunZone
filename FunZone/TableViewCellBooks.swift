//
//  TableViewCellBooks.swift
//  FunZone
//
//  Created by Xavier on 6/6/22.
//

import UIKit

class TableViewCellBooks: UITableViewCell {

    @IBOutlet weak var imageViewBookCover: UIImageView!
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelBookName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
