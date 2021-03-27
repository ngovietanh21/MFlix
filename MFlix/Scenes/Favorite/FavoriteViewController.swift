//
//  FavoriteViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class FavoriteViewController: UIViewController, BindableType {
    
    //MARK: - Variable
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - ViewModel
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        
        let input = FavoriteViewModel.Input(loadTrigger: Driver.just(()),
                                            deletedMovieTrigger: tableView.rx.itemDeleted.asDriver(),
                                            selectedMovieTrigger: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.movies
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self).then {
                    $0.selectionStyle = .none
                    $0.setContentForCell(item)
                }
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isEmptyMovie
            .drive(tableView.rx.isEmpty(message: "No movies"))
            .disposed(by: rx.disposeBag)
        
        output.deletedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - Config View
extension FavoriteViewController {
    
    private func configView() {
        configNavigation()
        configTableView()
    }
    
    private func configNavigation() {
        navigationItem.title = Constants.favoriteString
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.rowHeight = $0.frame.height * 1 / 8
        }
    }
}

extension FavoriteViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.favorite
}
