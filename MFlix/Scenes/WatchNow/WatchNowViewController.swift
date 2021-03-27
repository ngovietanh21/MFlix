//
//  WatchNowViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class WatchNowViewController: UIViewController, BindableType {
    
    //MARK: - Variable
    @IBOutlet private weak var tableView: UITableView!
    private var listCell = [WatchNowCellType]()
    private var storedOffsets = [Int: CGFloat]()
    
    //MARK: - View Model
    var viewModel: WatchNowViewModel!
    private let seeAllTrigger = PublishSubject<CategoryType>()
    private let movieDetailTrigger = PublishSubject<Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {

        let input = WatchNowViewModel.Input(
            loadTrigger: Driver.just(()),
            seeAllTrigger: seeAllTrigger.asDriverOnErrorJustComplete(),
            movieDetailTrigger: movieDetailTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.items
            .drive(tableView.rx.items) { [unowned self] tableView, index, item in
                if !(self.listCell.contains(item)) {
                    self.listCell.append(item)
                }
                let indexPath = IndexPath(item: index, section: 0)
                let cell: WatchNowTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.do {
                    $0.selectionStyle = .none
                    $0.category = item.category
                    $0.didSelectSeeAllButton = { [unowned self] category in
                        if let category = category {
                           self.seeAllTrigger.onNext(category)
                        }
                    }
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.seeAllSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.movieDetailSelected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - ConfigView
extension WatchNowViewController {
    private func configView() {
        configNavigation()
        configTableView()
    }
    
    private func configNavigation() {
        navigationItem.title = Constants.watchNowString
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: WatchNowTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.delegate = self
            $0.estimatedRowHeight = 200
        }
    }
}

//MARK: - UITableViewDelegate
extension WatchNowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WatchNowTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WatchNowTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

//MARK: - UICollectionViewDataSource
extension WatchNowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCell[collectionView.tag].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WatchNowCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(listCell[collectionView.tag].movies[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension WatchNowViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = listCell[collectionView.tag].movies[indexPath.row]
        movieDetailTrigger.onNext(movie)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WatchNowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 3 / 4 - 10
        let height = collectionView.frame.height + 5
        return CGSize(width: width, height: height)
    }
}

//MARK: - StoryboardSceneBased
extension WatchNowViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.watchNow
}

