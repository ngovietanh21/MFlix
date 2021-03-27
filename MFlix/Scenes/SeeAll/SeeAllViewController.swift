//
//  SeeAllViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class SeeAllViewController: UIViewController, BindableType {

    //MARK: - IBOutLet
    @IBOutlet private weak var collectionView: LoadMoreCollectionView!
    
    //MARK: - View Model
    var viewModel: SeeAllViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        
        let input = SeeAllViewModel.Input(loadTrigger: Driver.just(()),
                                          reloadTrigger: collectionView.refreshTrigger,
                                          loadMoreTrigger: collectionView.loadMoreTrigger,
                                          selectMovieTrigger: collectionView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.movies
            .drive(collectionView.rx.items) { collectionView, row, movie in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: SeeAllCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.isReloading
            .drive(collectionView.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        output.isLoadingMore
            .drive(collectionView.isLoadingMore)
            .disposed(by: rx.disposeBag)
        
        output.movieSelected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - ConfigView
extension SeeAllViewController {
    private func configView() {
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: SeeAllCollectionViewCell.self)
            $0.delegate = self
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SeeAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1 / 2 - 10
        let height = width * 0.82
        return CGSize(width: width, height: height)
    }
}

//MARK: - StoryboardSceneBased
extension SeeAllViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.seeAll
}
