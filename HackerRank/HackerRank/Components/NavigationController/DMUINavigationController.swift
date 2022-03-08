//
//  UINavigationController.swift
//  HackerRank
//
//  Created by Daniel Maia dos Passos on 14/02/22.
//

import UIKit

public protocol Themeable {
  var navigationBarBackgroundColor: UIColor { get }
  var navigationBarTintColor: UIColor { get }
  var navigationTitleTextAttributes: [NSAttributedString.Key : Any] { get }
  var navigationBarStyle: UIBarStyle { get }
  var navigationBarTranslucent: Bool { get }
  var customBackButtonAction: Selector? { get }
  var customRightButtonAction: Selector? { get }
  var iconBackButton: UIImage { get }
  var iconRightButton: UIImage { get }
}

public class DMUINavigationController: UINavigationController {
  
  // MARK: - Properties
  
  public var statusBarStyle: UIStatusBarStyle = .default {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  public var statusBarHidden: Bool = false {
    didSet {
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Lifecycle
  required convenience init() {
    self.init(navigationBarClass: nil, toolbarClass: nil)
  }
  
  override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
    styleViewController(viewController: viewController)
  }
  
  override public func popViewController(animated: Bool) -> UIViewController? {
    let destinationVC = viewControllers.dropLast().last
    let poped = super.popViewController(animated: animated)
    
    styleViewController(viewController: destinationVC)
    
    return poped
  }
  
  override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
    let poped = super.popToViewController(viewController, animated: animated)
    styleViewController(viewController: viewController)
    
    return poped
  }
  
  override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
    _ = viewControllers.map({ styleViewController(viewController: $0) })
  }
  
  override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    super.dismiss(animated: flag, completion: completion)
  }
  
  override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
    let poped = super.popToRootViewController(animated: animated)
    _ = viewControllers.map({ styleViewController(viewController: $0) })
    
    return poped
  }
  
  
  private func styleViewController(viewController: UIViewController?) {
    if let vc = viewController as? Themeable {
      switch vc {
      case is WhiteNavigationTheme:
        self.customizeBackButton(icon: vc.iconBackButton)
        self.hiddenNavigation(false)
        self.removeNavigationImage()
      default:
        break
      }
      
      if #available(iOS 15, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = vc.navigationTitleTextAttributes
        appearance.backgroundColor = vc.navigationBarBackgroundColor
        appearance.shadowColor = .clear
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
      }
      
      self.setNeedsStatusBarAppearanceUpdate()
      self.navigationBar.isTranslucent = vc.navigationBarTranslucent
      self.navigationBar.barTintColor = vc.navigationBarBackgroundColor
      self.navigationBar.tintColor = vc.navigationBarTintColor
      self.navigationBar.titleTextAttributes = vc.navigationTitleTextAttributes
      
      // Configure and replace back button to custom back if necessary
      if let action = vc.customBackButtonAction {
        self.configureCustomBackButton(with: viewController, action: action)
      }
      
      // Configure and replace right button to custom action if necessary
      if let action = vc.customRightButtonAction {
        self.configureCustomRightButton(with: viewController, action: action)
      }
    }
  }
  
  private func customizeBackButton(icon: UIImage) {
    let backArrowImage = icon
    navigationBar.backIndicatorImage = backArrowImage
    navigationBar.backIndicatorTransitionMaskImage = backArrowImage
  }
  
  private func removeNavigationShadow() {
    navigationBar.shadowImage = UIImage()
  }
  
  private func removeNavigationImage() {
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    removeNavigationShadow()
  }
  
  private func hiddenNavigation(_ hidden: Bool) {
    self.setNavigationBarHidden(hidden, animated: true)
  }
  
  private func removeBackButtonTitle(from viewController: UIViewController?) {
    let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    viewController?.navigationItem.backBarButtonItem = item
    
    // Remove back button title after iOS 12.1
    viewController?.navigationController?.navigationBar.topItem?.backBarButtonItem = item
  }

  private func configureCustomBackButton(with viewController: UIViewController?, action: Selector) {
    let icon: UIImage? = (viewController as? Themeable)?.iconBackButton
    let customBackButton = UIBarButtonItem(image: icon, style: .plain, target: viewController, action: action)
    
    viewController?.navigationItem.leftBarButtonItem = customBackButton
  }
  
  private func configureCustomRightButton(with viewController: UIViewController?, action: Selector) {
    let icon: UIImage? = (viewController as? Themeable)?.iconRightButton
    let customRightButton = UIBarButtonItem(image: icon, style: .plain, target: viewController, action: action)
    
    viewController?.navigationItem.rightBarButtonItem = customRightButton
  }
}
