//
//  TableViewCellMusic.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit

class TableViewCellMusic: UITableViewCell {

    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelAlbumName: UILabel!
    @IBOutlet weak var labelSongNameSingerName: UILabel!
    @IBOutlet weak var imageViewArtwork: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
