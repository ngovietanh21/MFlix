//
//  CastCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class CastCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var castImageView: UIImageView!
    @IBOutlet private weak var realNameLabel: UILabel!
    @IBOutlet private weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.makeRounded()
    }
    
    func setContentForCell(_ cast: Person) {
        realNameLabel.text = cast.name
        characterLabel.text = cast.character
        castImageView.sd_setImage(with: URL(string: cast.imageOriginalUrl),
                                  placeholderImage: Constants.imagePersonPlaceHolder)
        castImageView.makeRounded()
    }
}
