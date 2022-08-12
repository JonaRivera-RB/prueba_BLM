//
//  RecoveryDataViewController.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 12/08/22.
//

import Foundation
import UIKit

class RecoveryDataViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var dataTableView: UITableView!

    // MARK: - Properties
    private var viewModel: RecoveryDataViewModel!
    public var coordinator: Coordinator?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecoveryDataViewModel(recoveryData: RecoveryDataUseCase())
        setUI()
        bind()
        
        viewModel.getRecoveryData()
    }
    
    func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            if let errorAPI = error {
                guard let self = self else { return }
                //MARK: - refactor this code, show error
            }
        }
        
        viewModel.recoveryDataResponse.observe(on: self) { [weak self] result in
            if result == true {
                self?.updateUI()
            }
        }
    }

    // MARK: - Functions
    private func setUI() {
        dataTableView.delegate = self
        dataTableView.dataSource = self
    }
    
    func updateUI() {
        dataTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RecoveryDataViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension RecoveryDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    //MARK: - refactor this code, this code must be in the cell viewmodel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? UITableViewCell else { fatalError() }
        cell.textLabel?.text = viewModel.getDataForRow(index: indexPath.row)?.name
        cell.detailTextLabel?.text = viewModel.getDataForRow(index: indexPath.row)?.email
        return cell
    }
    
}

// MARK: - Storyboarded
extension RecoveryDataViewController: Storyboarded {

    static var storyboardName: String {
        return "RecoveryDataView"
    }
}
