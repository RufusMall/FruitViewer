//
//  FruitListViewController.swift
//  FruitViewer
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import UIKit

class FruitListViewController: UIViewController, FruitListViewDelegate {
    let viewModel: FruitListViewModel
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    init(viewModel: FruitListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemRed
        label.backgroundColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FruitCell.self, forCellReuseIdentifier: FruitCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private func configureLayout() {
        navigationItem.largeTitleDisplayMode = .always
        
        self.view.addSubview(tableView)
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlChanged), for: .valueChanged)
        tableView.constrainPinningEdgesToSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        viewModel.start()
    }
    
    @objc func refreshControlChanged(sender: Any?) {
        viewModel.refresh()
    }
    
    func didUpdate(viewModel: FruitListViewModel) {
        self.title = viewModel.title
        refreshControl.endRefreshing()
        tableView.reloadData()
        
        if viewModel.shouldShowError {
            errorLabel.text = viewModel.errorMesage
            view.addSubview(errorLabel)
            errorLabel.constrainPinningEdgesToSuperview(useSystemSpacing: true, multiplier: 1.0)
        } else {
            errorLabel.removeFromSuperview()
        }
    }
}

extension FruitListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FruitCell.reuseIdentifier, for: indexPath) as! FruitCell
        let cellVM = viewModel.cellViewModel(for: indexPath)
        cell.configure(viewModel: cellVM)
        return cell
    }
}

extension FruitListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}
