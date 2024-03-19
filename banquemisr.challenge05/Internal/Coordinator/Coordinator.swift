//
//  Coordinator.swift
//  banquemisr.challenge05
//
//  Created by mohammed balegh on 13/03/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
}

protocol ParentCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()

    func addChild(_ child: Coordinator?)
    func childDidFinish(_ child: Coordinator?)
}

extension ParentCoordinator {

    func addChild(_ child: Coordinator?){
        if let child {
            childCoordinators.append(child)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

protocol ChildCoordinator: Coordinator {
    var parentCoordinator : ParentCoordinator? { get set }

    func coordinatorDidFinish()
}
