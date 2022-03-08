//
//  BookBestSellerModel.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

struct BookBestSellerModel: Codable {
  var best_sellers: [String] = []

  init() {}
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.best_sellers = try container.decodeIfPresent([String].self, forKey: .best_sellers) ?? []
  }
}

struct BookBestSellerResponseModel: Codable {
  var results: BookBestSellerModel = BookBestSellerModel.init()

  init() {}
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.results = try container.decodeIfPresent(BookBestSellerModel.self, forKey: .results) ?? BookBestSellerModel.init()
  }
}
