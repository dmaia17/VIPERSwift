//
//  HRMainViewControllerViewController.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit

final class HRMainViewControllerViewController: UIViewController, WhiteNavigationTheme {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Class properties
  
  // MARK: - Public properties  

  var presenter: HRMainViewControllerPresenterInterface!
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewConfiguration()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.layoutIfNeeded()
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  // MARK: - Class Configurations  

  private func viewConfiguration() {
    title = presenter.navTitle
    presenter.viewDidLoad()
    configTableView()
  }

  // MARK: - UIActions

  // MARK: - Class Methods
  
  private func configTableView() {
    let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: BookTableViewCell.cellIdentifier)
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.sizeToFit()
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
  }
  
}

// MARK: - Extensions

extension HRMainViewControllerViewController: HRMainViewControllerViewInterface {
  func reloadTableView() {
    tableView.reloadData()
  }
}

extension HRMainViewControllerViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.numberOfItens(tableView, numberOfRowsInSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return presenter.cellForIndex(index: indexPath, tableView: tableView)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectRowAt(index: indexPath.row, tableView: tableView)
  }
}
