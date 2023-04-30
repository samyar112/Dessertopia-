//
//  ViewController.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import UIKit
import SwiftUI

class DessertViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DessertTableViewCell.self, forCellReuseIdentifier: DessertCellReuseId.cellId)
        return tableView
    }()
    
    private let dessertViewModel = DessertViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTable()
    }
    
    // MARK: - Helpers
    
    private func loadData() {
        //Loading Indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
        
        self.dessertViewModel.fetchData()
        self.dessertViewModel.didUpdateData = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.title = DessertVCConstant.title
                self.tableView.reloadData()
                activityIndicator.stopAnimating()
                self.tableView.backgroundView = nil
            }
        }
        
        self.dessertViewModel.onErrorMessage = { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                //showing alert when network fails so user can retry or connect to internet.
                self.showErrorAlert()
            }
        }
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = CGFloat(DessertVCConstant.rowHeight)
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: nil , message: ErrorAlertConstant.alertMessage , preferredStyle: .alert)
        let retryAction = UIAlertAction(title: ErrorAlertConstant.retryButton , style: .default) { [ weak self ] _ in
            guard let self = self else { return }
            self.dessertViewModel.fetchData()
        }
        alertController.addAction(retryAction)
        present(alertController, animated: true)
    }
}

// MARK: - Setup Table

extension DessertViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertViewModel.desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DessertCellReuseId.cellId, for: indexPath) as? DessertTableViewCell else {
            fatalError(DessertVCConstant.fatalErrorAtCell)
        }
        cell.selectionStyle = .none
        
        let dessertItems = dessertViewModel.desserts[indexPath.row]
        cell.configureCell(with: dessertItems)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealId = self.dessertViewModel.desserts[indexPath.row].idMeal
        // Using UIHostingController to navigate to SwiftUI View.
        let detailVC = UIHostingController(rootView: DessertDetailScreen(mealId: mealId))
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
