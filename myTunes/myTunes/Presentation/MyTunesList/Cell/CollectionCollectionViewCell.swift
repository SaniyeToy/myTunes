//
//  CollectionCollectionViewCell.swift
//  myTunes
//
//  Created by MacOS on 24.03.2022.
//

import UIKit

class CollectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewUrl: UILabel!
    @IBOutlet weak var wrapperType: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        
    }

}
