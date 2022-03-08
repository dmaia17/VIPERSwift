//
//  BookModel.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

struct BookModel: Codable {
  var isbn: String = ""
  var title: String = ""
  var author: String = ""
  var description: String = ""
  var genre: String = ""
  var img: String = ""
  
  init() {}
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.isbn = try container.decodeIfPresent(String.self, forKey: .isbn) ?? ""
    self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
    self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    self.genre = try container.decodeIfPresent(String.self, forKey: .genre) ?? ""
    self.img = try container.decodeIfPresent(String.self, forKey: .img) ?? ""
  }
}

struct BookListModel: Codable {
  var books: [BookModel] = []

  init() {}
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.books = try container.decodeIfPresent([BookModel].self, forKey: .books) ?? []
  }
}

struct BookResponseModel: Codable {
  var results: BookListModel = BookListModel.init()

  init() {}
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.results = try container.decodeIfPresent(BookListModel.self, forKey: .results) ?? BookListModel.init()
  }
}
