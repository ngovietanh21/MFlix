//
//  MovieDetailViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class MovieDetailViewController: UIViewController, BindableType {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    //MARK: - Varibale
    private var storedOffsets = [Int: CGFloat]()
    private var listCell = [MovieDetailTableViewCellType]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var favoriteBarButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "heart"),
                               style: .plain,
                               target: nil,
                               action: nil)
    }()
    
    //MARK: - View Model
    var viewModel: MovieDetailViewModel!
    private let trailerVideoTrigger = PublishSubject<Video>()
    private let movieDetailTrigger = PublishSubject<Movie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(loadTrigger: Driver.just(()),
                                               buttonFavoriteTrigger: favoriteBarButton.rx.tap.asDriver(),
                                               movieDetailTrigger: movieDetailTrigger.asDriverOnErrorJustComplete(),
                                               trailerVideoTrigger: trailerVideoTrigger.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.movieDetail
            .drive(self.movieDetail)
            .disposed(by: rx.disposeBag)
        
        output.movieDetailSection
            .drive(items)
            .disposed(by: rx.disposeBag)
        
        output.movieDetailSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.trailerVideoSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.buttonFavoriteSelected
            .drive(self.trackingFavoriteButton)
            .disposed(by: rx.disposeBag)
        
        tableView.rx
            .didEndDisplayingCell
            .subscribe(onNext: { [unowned self] cell, indexPath in
                guard let tableViewCell = cell as? MovieDetailTableViewCell else { return }
                self.storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
            })
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - Config View
extension MovieDetailViewController {
    private func configView() {
        configNavigationItem()
        configTableView()
    }
    
    private func configNavigationItem() {
        navigationItem.do {
            $0.largeTitleDisplayMode = .never
            $0.rightBarButtonItem = favoriteBarButton
        }
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: MovieDetailTableViewCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func updateView(from movie: MovieDetail) {
        titleLabel.text = movie.title
        navigationItem.title = movie.title
        descriptionTextView.text = movie.overview
        genresLabel.text = movie.genres.map { $0.name }.joined(separator: " · ")
        
        let url = movie.hasBackDropImage
            ? URL(string: movie.backdropImageW500Url)
            : URL(string: movie.posterImageW500Url)
        movieImageView.sd_setImage(with: url)
    }
}

//MARK: - Reactive
extension MovieDetailViewController {
    private var movieDetail: Binder<MovieDetail> {
        return Binder(self) { vc, movieDetail in
            vc.updateView(from: movieDetail)
        }
    }
    
    private var items: Binder<[MovieDetailTableViewCellType]> {
        return Binder(self) { vc, listCell in
            vc.listCell = listCell
        }
    }
    
    private var trackingFavoriteButton: Binder<Bool> {
        return Binder(self) { vc, favorite in
            let systemName = favorite ? "heart.fill" : "heart"
            vc.favoriteBarButton.image = UIImage(systemName: systemName)
        }
    }
}

//MARK: - UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
}

//MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath,cellType: MovieDetailTableViewCell.self).then {
            [unowned self] in
            $0.selectionStyle = .none
            $0.section = listCell[indexPath.row].section
            $0.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch listCell[collectionView.tag] {
        case .trailer(let videos):
            let video = videos[indexPath.row]
            trailerVideoTrigger.onNext(video)
            
        case .related(let movies):
            let movie = movies[indexPath.row]
            movieDetailTrigger.onNext(movie)
        default:
            break
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCell[collectionView.tag].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch listCell[collectionView.tag] {
        case .related(let movies):
            let cell: RelatedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(movies[indexPath.row])
            return cell

        case .cast(let actors):
            let cell: CastCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(actors[indexPath.row])
            return cell
            
        case .trailer(let videos):
            let cell: TrailerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(videos[indexPath.row])
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch listCell[collectionView.tag] {
        case .related, .trailer:
            let width = collectionView.frame.width * 0.7
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
            
        case .cast:
            let width = collectionView.frame.width * 1 / 3
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
}

//MARK: - StoryboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movieDetail
}
