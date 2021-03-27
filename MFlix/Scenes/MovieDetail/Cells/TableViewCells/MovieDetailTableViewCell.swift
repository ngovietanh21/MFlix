//
//  MovieDetailTableViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class MovieDetailTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var sectionLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    var section: String? {
        didSet {
            sectionLabel.text = section
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: CastCollectionViewCell.self)
            $0.register(cellType: RelatedCollectionViewCell.self)
            $0.register(cellType: TrailerCollectionViewCell.self)
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate,
                                             forRow row: Int) {
        collectionView.do {
            $0.delegate = dataSourceDelegate
            $0.dataSource = dataSourceDelegate
            $0.tag = row
            $0.setContentOffset(collectionView.contentOffset, animated: false)
            $0.reloadData()
        }
    }
}
