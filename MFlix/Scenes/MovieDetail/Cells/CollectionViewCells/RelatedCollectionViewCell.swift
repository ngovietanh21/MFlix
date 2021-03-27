//
//  RelatedCollectionViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class RelatedCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    
    func setContentForCell(_ movie: Movie) {
        let url = movie.hasBackDropImage
            ? URL(string: movie.backdropImageW500Url)
            : URL(string: movie.posterImageW500Url)
        
        movieImageView.sd_setImage(with: url, placeholderImage: Constants.imageMoviePlaceHolder)
    }
}
