//
//  WatchNowTableViewCell.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    var didSelectSeeAllButton: ((CategoryType?) -> Void)?
    
    var category: CategoryType? {
        didSet {
            titleLabel.text = category?.title
        }
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: WatchNowCollectionViewCell.self)
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.do {
            $0.delegate = dataSourceDelegate
            $0.dataSource = dataSourceDelegate
            $0.tag = row
            $0.setContentOffset(collectionView.contentOffset, animated: false)
            $0.reloadData()
        }
    }
    
    @IBAction private func didSelectSeeAllButton(_ sender: UIButton) {
        didSelectSeeAllButton?(category)
    }
}
