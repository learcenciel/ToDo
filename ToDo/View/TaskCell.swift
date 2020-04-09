//
//  TaskCell.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

class TaskCell: BaseCell {
    
    let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Meet Lorence"
        return label
    }()
    
    let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 81, green: 78, blue: 78)
        label.text = "asdasdads"
        return label
    }()
    
    let taskColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        return view
    }()
    
    var taskColor: UIColor? {
        get {
            return taskColorView.backgroundColor
        }
        
        set {
            taskColorView.backgroundColor = newValue
        }
    }
    
    override func setupViews() {
        
        backgroundColor = .white
        selectionStyle = .none
        
        setupTaskContainerView()
    }
    
    func setupTaskContainerView() {
        
        addSubview(taskTitleLabel)
        addSubview(taskDescriptionLabel)
        addSubview(taskColorView)
        
        taskColorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.height / 3).isActive = true
        taskColorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        taskColorView.heightAnchor.constraint(equalToConstant: frame.height / 3).isActive = true
        taskColorView.widthAnchor.constraint(equalToConstant: frame.height / 3).isActive = true
        taskColorView.layer.cornerRadius = (frame.height / 3) / 2
        
        taskTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        taskTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: taskColorView.leadingAnchor, constant: -frame.height / 3).isActive = true
        
        taskDescriptionLabel.leadingAnchor.constraint(equalTo: taskTitleLabel.leadingAnchor).isActive = true
        taskDescriptionLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 4).isActive = true
        taskDescriptionLabel.trailingAnchor.constraint(equalTo: taskTitleLabel.trailingAnchor).isActive = true
    }
    
    func setup(task: Task) {
        self.taskTitleLabel.text = task.title
        self.taskDescriptionLabel.text = task.descript
        let taskRGBColor = UIColor(red: CGFloat(task.red), green: CGFloat(task.green), blue: CGFloat(task.blue), alpha: 1.0)
        self.taskColor? = taskRGBColor
    }
}
