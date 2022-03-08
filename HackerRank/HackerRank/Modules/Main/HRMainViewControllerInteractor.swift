//
//  HRMainViewControllerInteractor.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import Foundation

final class HRMainViewControllerInteractor {
  private let provider: BookProvider
  weak var response: HRMainViewControllerInteractorResponseProtocol?
  private var books: [BookModel] = []
  private var bestSellers: [String] = []
  
  init(provider: BookProvider) {
    self.provider = provider
  }
}

// MARK: - Extensions

extension HRMainViewControllerInteractor: HRMainViewControllerInteractorProtocol {
  func getBooks() {
    provider.getBooks(successCallback: { [weak self] books in
      self?.response?.getBooksSuccess(list: books.results.books)
    }, failureCallback: { [weak self] in
      self?.response?.getBooksError()
    })
  }
}

extension HRMainViewControllerInteractor: NetworkingInteractorResponse {
  func networkingAvailable() {
  }
  
  func networkingNotAvailable() {
  }
}
