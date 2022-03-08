//
//  HRMainViewControllerWireframe.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit

final class HRMainViewControllerWireframe: BaseWireframe {
  
  // MARK: - Private properties

  private let moduleViewController = HRMainViewControllerViewController(nibName: nil, bundle: nil)
  
  // MARK: - Module setup

  func configureModule(with viewController: HRMainViewControllerViewController) {
    let interactor = HRMainViewControllerInteractor(provider: BookProvider())
    let presenter = HRMainViewControllerPresenter(wireframe: self, view: viewController, interactor: interactor)
    
    interactor.response = presenter
    viewController.presenter = presenter
  }
  
  // MARK: - Transitions
  func show(with transition: Transition, animated: Bool = true) {
    configureModule(with: moduleViewController)
    show(moduleViewController, with: transition, animated: animated)
  }
  
  // MARK: - Private Routing

}

// MARK: - Extensions

extension HRMainViewControllerWireframe: HRMainViewControllerWireframeInterface {
  func navigate(to option: HRMainViewControllerNavigationOption) {
    // switch option {
    // case <#pattern#>:
    //   <#code#>      
    // }
  }
}
