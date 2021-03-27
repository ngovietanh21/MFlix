//
//  SearchViewController.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class SearchViewController: UIViewController, BindableType {
    
    //MARK: - Variable
    @IBOutlet private weak var tableView: LoadMoreTableView!
    
    private var searchController: UISearchController!
    
    fileprivate enum Text: String {
        case placeholder = "MFLix App"
        case emptySearchBar = "Search Movie"
        case emptyResult = "No results\nTry a different search"
    }
    
    //MARK: - ViewModel
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func bindViewModel() {
        
        let input = ViewModelType.Input(textSearch: searchController.searchBar.rx.text.orEmpty.asDriver(),
                                        reloadTrigger: tableView.refreshTrigger,
                                        loadMoreTrigger: tableView.loadMoreTrigger,
                                        selectMovieTrigger: tableView.rx.itemSelected.asDriver())
        
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
        
        output.movieSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.isLoadingMore
            .drive(tableView.isLoadingMore)
            .disposed(by: rx.disposeBag)
        
        output.isReloading
            .drive(tableView.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        output.isEmptyMovie
            .drive(tableView.rx.isEmpty(message: Text.emptyResult.rawValue))
            .disposed(by: rx.disposeBag)
        
        output.isEmptyString
            .drive(tableView.rx.isEmpty(message: Text.emptySearchBar.rawValue))
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
    }
}

//MARK: - Config View
extension SearchViewController {
    
    private func configView() {
        initSearchController()
        configNavigation()
        configTableView()
    }
    
    private func initSearchController() {
        searchController = UISearchController(searchResultsController: nil).then {
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchBar.placeholder = Text.placeholder.rawValue
        }
    }
    
    private func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.do {
            $0.title = Constants.searchString
            $0.searchController = searchController
        }
    }
    
    private func configTableView() {
        tableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.rowHeight = $0.frame.height * 1 / 8
        }
    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.search
}
