//
//  ViewController.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 10/10/2022.
//

import UIKit

final class HomeViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var viewSuggestionList: UIView!
    @IBOutlet private weak var viewContainerList: UIView!
    @IBOutlet private weak var viewSearchBar: UIView!
    @IBOutlet private weak var lblEmptyData: UILabel!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var weatherTableViewController: WeatherTableViewController?
    
    private var viewModel: WeatherListViewModel!
    
    static func create(with viewModel: WeatherListViewModel) -> HomeViewController {
        let view = HomeViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: WeatherListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0)}
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0)}
    }
    
    private func updateItems() {
        weatherTableViewController?.reload()
    }
    
    private func updateLoading(_ loading: WeatherListViewModelLoading?) {
        lblEmptyData.isHidden = true
        viewContainerList.isHidden = true
        viewSuggestionList.isHidden = true
        LoadingView.hide()

        switch loading {
        case .fullScreen: LoadingView.show()
        case .nextPage: viewContainerList.isHidden = false
        case .none:
            viewContainerList.isHidden = viewModel.isEmpty
            lblEmptyData.isHidden = !viewModel.isEmpty
        }

        weatherTableViewController?.updateLoading(loading)
        updateQueriesSuggestions()
    }
    
    private func updateSearchQuery(_ query: String) {
        searchController.isActive = false
        searchController.searchBar.text = query
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else {return}
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    private func updateQueriesSuggestions() {
        guard searchController.searchBar.isFirstResponder else {
            viewModel.closeQueriesSuggestions()
            return
        }
        viewModel.showQueriesSuggestions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    private func setupViews() {
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: WeatherTableViewController.self),
            let destinationVC = segue.destination as? WeatherTableViewController {
            weatherTableViewController = destinationVC
            weatherTableViewController?.viewModel = viewModel
        }
    }
}


// MARK: - Search Controller

extension HomeViewController {
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .black
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchController.searchBar.frame = viewSearchBar.bounds
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        viewSearchBar.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}

extension HomeViewController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }
}

