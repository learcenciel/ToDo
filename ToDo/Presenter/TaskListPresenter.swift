//
//  TaskListPresenter.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

protocol TaskListDelegate: NSObjectProtocol {
    
    func displayAllTasks(tasks: [Task])
}

class TasksGroupsPresenter {
    
    private let taskListService: TaskListService
    
    let taskGroupsRouter: TaskListRouter = TaskListRouter.shared
    
    weak private var taskListDelegate : TaskListDelegate?
    
    init(taskListService: TaskListService){
        self.taskListService = taskListService
    }
    
    func setViewDelegate(taskListDelegate: TaskListDelegate?){
        self.taskListDelegate = taskListDelegate
    }
    
    func fetchAllTasks() {
        
        guard let tasks = taskListService.fetchAllTasks() else { return }
        self.taskListDelegate?.displayAllTasks(tasks: tasks)
    }
    
    func createTask(taskName: String, taskDescription: String?, taskColor: [Float]) {
        taskListService.createTask(title: taskName, description: taskDescription, color: taskColor)
    }

    func updateTask(taskName: String, taskDescription: String?, taskColor: [Float], uuId: UUID) {
        taskListService.updateTask(title: taskName, description: taskDescription, color: taskColor, uuId: uuId)
    }
    
    func deleteTask(uuId: UUID) {
        taskListService.deleteTask(uuId: uuId)
    }
    
    func cellEditTaskTapped(task: Task) {
        taskGroupsRouter.showTaskEditViewController(task: task)
    }
}
