//
//  HRMainViewControllerInterfaces.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit

enum HRMainViewControllerNavigationOption { }

protocol HRMainViewControllerWireframeInterface: WireframeInterface {
  func navigate(to option: HRMainViewControllerNavigationOption)
}

protocol HRMainViewControllerViewInterface: ViewInterface {
  func reloadTableView()
}

protocol HRMainViewControllerPresenterInterface: PresenterInterface {
  var navTitle: String { get }
  
  ///TableView
  func numberOfItens(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  func cellForIndex(index: IndexPath, tableView:UITableView) -> UITableViewCell
  func didSelectRowAt(index: Int, tableView: UITableView)
}

protocol HRMainViewControllerInteractorProtocol: InteractorInterface {
  func getBooks()
}

protocol HRMainViewControllerInteractorResponseProtocol: AnyObject {
  func networkingNotAvailable()
  func getBooksSuccess(list: [BookModel])
  func getBooksError()
}
