//
//  TableViewCell.swift
//  [PreOnBoarding] assignment
//
//  Created by 강민주 on 2023/03/01.
//

import UIKit


class TableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var loadButton: UIButton!
    
    var loadImageAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func loadImage(_ sender: Any) {
        loadImageAction?()
    }
}
