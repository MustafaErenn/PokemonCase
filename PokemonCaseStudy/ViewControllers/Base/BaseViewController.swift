//
//  BaseViewController.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import UIKit

class BaseViewController<T>: UIViewController {
    
    private var argument: Any?
    
    let child = LoadingBarViewController();
    let networkManager = NetworkManager();


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingBar() {
        addChild(self.child)
        self.child.view.frame = view.frame
        self.child.view.backgroundColor = .white;
        view.addSubview(self.child.view)
        self.child.didMove(toParent: self);
    }
    
    func hideLoadingBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
    
    func navigateToPage<M>(navigationConstant: NavigationConstant, navigationType: NavigationType, argument: M?) {
        let storyboardId: String = navigationConstant.rawValue.split(separator: ".").first!.description
        let viewControllerId: String = navigationConstant.rawValue.split(separator: ".").last!.description
        
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as! BaseViewController<M>
        viewController.argument = argument
        
        switch navigationType {
            case .show:
                self.show(viewController, sender: nil)
                break
            case .present:
                self.present(viewController, animated: true)
                break
            case .pageSheet:
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.modalPresentationStyle = .pageSheet
                if let sheet = navigationController.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                }
                self.present(navigationController, animated: true, completion: nil)
                break
        }
        

    }
    
    func getArgument() -> T {
        return argument as! T
    }

}
