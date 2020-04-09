//
//  ViewController.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

enum TasksGroupsCellType: String, CaseIterable {
    case allTasksCell = "AllTasksCell"
}

class TaskListViewController: UIViewController {
    
    var presenter = TasksGroupsPresenter(taskListService: TaskListService())
    var tasks: [Task]?
    
    lazy var tasksTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.rgb(red: 157, green: 171, blue: 177)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    override var isEditing: Bool {
        didSet {
            let setEditing = isEditing ? true : false
            if setEditing {
                self.navigationItem.rightBarButtonItem?.title = "Done"
            } else {
                self.navigationItem.rightBarButtonItem?.title = "Edit"
            }
            
            self.tasksTableView.setEditing(setEditing, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
        setupTaskListTableView()
        
        presenter.setViewDelegate(taskListDelegate: self)
        presenter.fetchAllTasks()
    }
    
    func setupViewController() {
        view.backgroundColor = .cyan
        
        view.backgroundColor = UIColor.rgb(red: 157, green: 171, blue: 177)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Task", style: .done, target: self, action: #selector(createTask))
    }
    
    func setupTaskListTableView() {
        
        view.addSubview(tasksTableView)
        
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TasksGroupsCellType.allTasksCell.rawValue)
        tasksTableView.showsVerticalScrollIndicator = false
        
        tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func createTask() {
        TaskListRouter.shared.showTaskCreateViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter.fetchAllTasks()
        self.tasksTableView.reloadData()
        
        super.viewWillAppear(animated)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksGroupsCellType.allTasksCell.rawValue, for: indexPath) as! TaskCell
        
        guard let task = tasks?[indexPath.section] else { fatalError() }
        
        cell.setup(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = UIColor.rgb(red: 157, green: 171, blue: 177)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let task = tasks?[indexPath.section] else { fatalError() }
        
        presenter.cellEditTaskTapped(task: task)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, completion in
            guard let task = self.tasks?[indexPath.section] else { return }
            self.presenter.deleteTask(uuId: task.id)
            self.tasks?.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension TaskListViewController: TaskListDelegate {
    func displayAllTasks(tasks: [Task]) {
        self.tasks = tasks
        self.tasksTableView.reloadData()
    }
}
