//
//  MainViewController.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 16.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Constants
    private let mainTableViewCellId = "MainTableViewCell"
    private let messageTitle = "MessageTitle"
    private let errorTextKey = "ErrorText"
    private let alertButtonTitleKey = "ErrorText"
    
    // MARK: - Properties
    private let refreshControl = UIRefreshControl()
    private var viewModel: MainViewModel!
    private var page: String = ""
    private var person: [Person] = []

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorLabel: ErrorLabel!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: self.mainTableViewCellId, bundle: nil), forCellReuseIdentifier: self.mainTableViewCellId)
        
        self.viewModel = MainViewModel()
        self.viewModel.delegate = self
        
        self.errorLabel.localizableKey = self.errorTextKey
        
        self.addRefreshControl()
    }
    
    private func addRefreshControl() {
        self.tableView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.tableView.isUserInteractionEnabled = false
        self.viewModel.fetch(next: page)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.mainTableViewCellId, for: indexPath) as! MainTableViewCell
        cell.mainTableViewCellMethod(name: self.person[indexPath.row].fullName, id: "\(self.person[indexPath.row].id)")
        return cell
    }
}

// MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    func updateTableView(_ response: FetchResponse?, error: FetchError?) {
        self.refreshControl.endRefreshing()
        if error == nil {
            guard let data = response else { return }
            self.page = data.next ?? "0"
            self.viewModel.unique(data: data, oldData: self.person) { newPerson in
                if newPerson.count > 0 {
                    self.tableView.isHidden = false
                    self.person = newPerson
                    self.tableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.tableView.isUserInteractionEnabled = true
                    }
                } else {
                    self.tableView.isHidden = true
                    self.viewModel.fetch(next: self.page)
                }
            }
        } else {
            let alert = UIAlertController(title: self.localizableGetString(forkey: self.messageTitle),
                                          message: error?.errorDescription ,
                                          preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: self.localizableGetString(forkey: self.alertButtonTitleKey), style: .default) { (action) in
                self.viewModel.fetch(next: self.page)
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

