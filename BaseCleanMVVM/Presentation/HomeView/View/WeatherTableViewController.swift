//
//  WeatherTableViewController.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var viewModel: WeatherListViewModel!
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func updateLoading(_ loading: WeatherListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            tableView.tableFooterView = nil
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        tableView.estimatedRowHeight = WeatherTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension WeatherTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? WeatherTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(WeatherTableViewCell.self) with reuseIdentifier: \(WeatherTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row])

        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isEmpty ? tableView.frame.height : super.tableView(tableView, heightForRowAt: indexPath)
    }
}
