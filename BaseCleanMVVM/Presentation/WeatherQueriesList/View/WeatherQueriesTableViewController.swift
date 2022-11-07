//
//  WeatherQueriesTableViewController.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

import UIKit

final class WeatherQueriesTableViewController: UITableViewController, StoryboardInstantiable {
    
    private var viewModel: WeatherQueryListViewModel!
    
    static func create(with viewModel: WeatherQueryListViewModel) -> WeatherQueriesTableViewController {
        let view = WeatherQueriesTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: WeatherQueryListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }
    
    // MARK: - Private

    private func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = WeatherQueriesItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension WeatherQueriesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherQueriesItemCell.reuseIdentifier, for: indexPath) as? WeatherQueriesItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(WeatherQueriesItemCell.self) with reuseIdentifier: \(WeatherQueriesItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
    }
}
