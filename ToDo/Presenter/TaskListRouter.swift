//
//  File.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class TaskListRouter {
    
    static let shared = TaskListRouter()
    
    private init() {
        
    }
    
    var taskListNavigationController: UINavigationController?
    
    var taskListViewController: TaskListViewController?
    
    func showTaskEditViewController(task: Task) {
        
        let taskEditViewController = TaskEditViewController()
        taskEditViewController.task = task
        
        taskListNavigationController?.pushViewController(taskEditViewController, animated: true)
    }
    
    func showTaskCreateViewController() {
        
        let taskCreateViewController = TaskCreateViewController()
        
        taskListNavigationController?.pushViewController(taskCreateViewController, animated: true)
    }
}
