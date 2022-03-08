//
//  BookProvider.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import Alamofire

protocol BookProviderProtocol {
  /**
   * Endpoint: https://raw.githubusercontent.com/ejgteja/files/main/books.json
   * Type: GET
   */
  func getBooks(successCallback: @escaping (BookResponseModel) -> Void, failureCallback: @escaping () -> Void)
  
  /**
   * Endpoint: https://raw.githubusercontent.com/ejgteja/files/main/books.json
   * Type: GET
   */
  func getBestSellers(successCallback: @escaping (BookBestSellerResponseModel) -> Void, failureCallback: @escaping () -> Void)
  
}

class BookProvider {
  
}

extension BookProvider: BookProviderProtocol {
  func getBooks(successCallback: @escaping (BookResponseModel) -> Void, failureCallback: @escaping () -> Void) {
    AF.request("https://raw.githubusercontent.com/ejgteja/files/main/books.json")
      .validate()
      .responseDecodable(of: BookResponseModel.self) { response in
        guard let books = response.value else {
          failureCallback()
          return
        }
        print(books)
        successCallback(books)
      }
  }
  
  func getBestSellers(successCallback: @escaping (BookBestSellerResponseModel) -> Void, failureCallback: @escaping () -> Void) {
    AF.request("https://raw.githubusercontent.com/ejgteja/files/main/best_sellers.json")
      .validate()
      .responseDecodable(of: BookBestSellerResponseModel.self) { response in
        guard let books = response.value else {
          print(response)
          failureCallback()
          return
        }
        print(books)
        successCallback(books)
      }
  }
}
