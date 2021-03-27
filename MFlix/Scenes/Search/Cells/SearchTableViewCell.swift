//
//  SearchTableViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/9/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        self.separatorInset = .init(top: 0,
                                    left: movieImageView.frame.width + 30,
                                    bottom: 0,
                                    right: 20)
    }
    
    func setContentForCell(_ movie: Movie) {
        let url = movie.hasBackDropImage ?
            URL(string: movie.backdropImageW500Url) : URL(string: movie.posterImageW500Url)
        
        movieTitleLabel.text = movie.title
        movieImageView.sd_setImage(with: url, placeholderImage: Constants.imageMoviePlaceHolder)
    }
}
