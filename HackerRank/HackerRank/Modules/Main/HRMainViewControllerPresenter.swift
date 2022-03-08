//
//  HRMainViewControllerPresenter.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit

final class HRMainViewControllerPresenter {

  // MARK: - Enums

  enum Strings {
    static let title = "Livros"
  }

  // MARK: - Private properties  

  private weak var view: HRMainViewControllerViewInterface?
  private let interactor: HRMainViewControllerInteractorProtocol
  private let wireframe: HRMainViewControllerWireframeInterface
  
  let navTitle = Strings.title
  private var books: [BookModel] = []
    
  // MARK: - Lifecycle

  init(wireframe: HRMainViewControllerWireframeInterface, view: HRMainViewControllerViewInterface, interactor: HRMainViewControllerInteractorProtocol) {
    self.wireframe = wireframe
    self.view = view
    self.interactor = interactor
  }
}

// MARK: - Extensions

extension HRMainViewControllerPresenter: HRMainViewControllerPresenterInterface {
  func viewDidLoad() {
    view?.fullScreenLoading(hide: false)
    interactor.getBooks()
  }
  
  func numberOfItens(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  func cellForIndex(index: IndexPath, tableView:UITableView) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellIdentifier, for: index) as? BookTableViewCell else {
      return UITableViewCell()
    }
    
    cell.setup(book: books[index.row])
    cell.selectionStyle = .none
    return cell
  }
  
  func didSelectRowAt(index: Int, tableView: UITableView) {
    //TODO: Implementar click
  }
}

extension HRMainViewControllerPresenter: HRMainViewControllerInteractorResponseProtocol {
  func networkingNotAvailable() {
    // TODO: Exibir alerta de sem conexão com a internet
    view?.fullScreenLoading(hide: true)
  }
  
  func getBooksSuccess(list: [BookModel]) {
    books = list
    view?.reloadTableView()
    view?.fullScreenLoading(hide: true)
  }
  
  func getBooksError() {
    // TODO: Exibir alerta de erro
    view?.fullScreenLoading(hide: true)
  }
}
