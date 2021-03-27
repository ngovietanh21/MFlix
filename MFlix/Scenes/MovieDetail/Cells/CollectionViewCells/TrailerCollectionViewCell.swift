//
//  TrailerCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class TrailerCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var videoImageView: UIImageView!
    @IBOutlet private weak var typeVideoLabel: UILabel!
    
    func setContentForCell(_ video: Video) {
        typeVideoLabel.text = video.type
        let url = URL(string: String(format: URLs.imageYoutube, video.key))
        videoImageView.sd_setImage(with: url, placeholderImage: Constants.imageMoviePlaceHolder)
    }
}
