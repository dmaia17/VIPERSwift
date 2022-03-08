//
//  NetworkingInteractor.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

protocol NetworkingInteractorProtocols {
  func check()
}

protocol NetworkingInteractorResponse {
  func networkingAvailable()
  func networkingNotAvailable()
}

class NetworkingInteractor {
  var networkCheck = NetworkCheck.sharedInstance()
  var response: NetworkingInteractorResponse?
}

extension NetworkingInteractor: NetworkingInteractorProtocols {
  func check() {
    if networkCheck.currentStatus == .satisfied {
      response?.networkingAvailable()
    } else {
      response?.networkingNotAvailable()
    }
  }
}
