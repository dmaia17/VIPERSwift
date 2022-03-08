//
//  InteractorInterface.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

protocol InteractorInterface: AnyObject {
  var networking: NetworkingInteractor { get }
}

extension InteractorInterface {
  var networking: NetworkingInteractor {
    let interactor = NetworkingInteractor()
    interactor.response = self as? NetworkingInteractorResponse
    return interactor
  }
}
