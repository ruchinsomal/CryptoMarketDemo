//
//  MarketElementCell.swift
//  CryptoMarketDemo
//
//  Created by Ruchin Somal on 2021-06-19.
//

import UIKit

class MarketElementCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(forIndexPath indexPath: IndexPath = IndexPath(row: 0, section: 0), withObject obj: Any? = nil) {
        if indexPath.row == 0 {
            nameLabel.text = "# Name"
            priceLabel.text = "Price"
            progressLabel.text = "24h"
            priceLabel.textColor = .black
            progressLabel.textColor = .black
            return
        }
        self.selectionStyle = .none
        if let cObj = obj as? MarketElement {
            nameLabel.text = "\(indexPath.row) " + cObj.name
            priceLabel.text = cObj.priceUsd.decimalDigit().formatAsNumber()
            let progressText = cObj.changePercent24Hr.doubleValue() > 0 ? "+\(cObj.changePercent24Hr.decimalDigit())%" : "\(cObj.changePercent24Hr.decimalDigit())%"
            progressLabel.text = progressText
            let textColor = cObj.changePercent24Hr.doubleValue() > 0 ? UIColor.systemGreen : UIColor.systemRed
            priceLabel.textColor = textColor
            progressLabel.textColor = textColor
        }
    }
    
}
