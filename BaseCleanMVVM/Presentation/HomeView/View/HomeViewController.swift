//
//  ViewController.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 10/10/2022.
//

import UIKit

final class HomeViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var viewSuggestionList: UIView!
    @IBOutlet private weak var viewContainerList: UIView!
    @IBOutlet private weak var viewSearchBar: UIView!
    @IBOutlet private weak var lblEmptyData: UILabel!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var weatherTableViewController: WeatherTableViewController?
    
    static func create() -> HomeViewController {
        let view = HomeViewController.instantiateViewController()
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    private func setupViews() {
        setupSearchController()
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
    
}

extension HomeViewController: UISearchControllerDelegate {
    
}

