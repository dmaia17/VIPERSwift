//
//  BookTableViewCell.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit
import SGImageCache

class BookTableViewCell: UITableViewCell {
  
  static let cellIdentifier: String = "BookTableViewCell"

  @IBOutlet weak var iconImageView: SGImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  
  func setup(book: BookModel) {
    iconImageView.setImageForURL(book.img)
    titleLabel.text = book.title
    descriptionLabel.text = book.description
    authorLabel.text = book.author
  }
    
}
