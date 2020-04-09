//
//  CreateTaskViewController.swift
//  ToDo
//
//  Created by Alexander on 07.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import ChromaColorPicker
import UIKit

class TaskCreateViewController: UIViewController {
    
    var presenter = TasksGroupsPresenter(taskListService: TaskListService())
    
    let editNewTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 32)
        label.text = "Create Task"
        return label
    }()
    
    let editNewTaskSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let topicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 22)
        label.text = "Topic"
        return label
    }()
    
    let topicTitleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        tf.attributedPlaceholder = NSAttributedString(
            string: "Write Topic",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 14) as Any])
        return tf
    }()
    
    let topicTitleTextFieldBottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 22)
        label.text = "Description"
        return label
    }()
    
    let descriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        tf.attributedPlaceholder = NSAttributedString(
            string: "Write Description",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 14)])
        return tf
    }()
    
    let descriptionTextFieldBottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    var selectedColorHandle = UIColor(red: 1, green: 203 / 255, blue: 164 / 255, alpha: 1)
    
    lazy var colorPickerView: ChromaColorPicker = {
        let cp = ChromaColorPicker()
        cp.translatesAutoresizingMaskIntoConstraints = false
        return cp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 72, green: 94, blue: 104)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(saveTapped))
        
        setupViews()
        setupColorPicker()
    }
    
    @objc func saveTapped() {
        
        var taskColor: [Float]!
        guard let taskName = topicTitleTextField.text, taskName.isEmpty == false else { return }
        var taskDescription = descriptionTextField.text
        
        if taskDescription!.isEmpty { taskDescription = "No description" }
        
        if let currentColor = colorPickerView.currentHandle?.color.cgColor.components {
            taskColor = currentColor.compactMap({ (color) in
                Float(color)
            })
        } else {
            let currentColor: [Float]! = colorPickerView.handles.first?.color.cgColor.components?.compactMap({ color  in
                Float(color)
            })
            
            taskColor = [currentColor[0], currentColor[1], currentColor[2]]
        }
        
        presenter.createTask(taskName: taskName, taskDescription: taskDescription, taskColor: taskColor)
        
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        
        view.addSubview(editNewTaskLabel)
        view.addSubview(editNewTaskSeparatorView)
        
        view.addSubview(topicTitleLabel)
        view.addSubview(topicTitleTextField)
        view.addSubview(topicTitleTextFieldBottomLineView)
        
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(descriptionTextFieldBottomLineView)
        
        
        editNewTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        editNewTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        
        editNewTaskSeparatorView.leadingAnchor.constraint(equalTo: editNewTaskLabel.trailingAnchor, constant: 42).isActive = true
        editNewTaskSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        editNewTaskSeparatorView.centerYAnchor.constraint(equalTo: editNewTaskLabel.centerYAnchor, constant: -4).isActive = true
        
        topicTitleLabel.topAnchor.constraint(equalTo: editNewTaskLabel.bottomAnchor, constant: view.frame.height / 8).isActive = true
        topicTitleLabel.leadingAnchor.constraint(equalTo: editNewTaskLabel.leadingAnchor).isActive = true
        
        topicTitleTextField.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor).isActive = true
        topicTitleTextField.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 14).isActive = true
        
        topicTitleTextFieldBottomLineView.leadingAnchor.constraint(equalTo: topicTitleTextField.leadingAnchor).isActive = true
        topicTitleTextFieldBottomLineView.topAnchor.constraint(equalTo: topicTitleTextField.bottomAnchor).isActive = true
        topicTitleTextFieldBottomLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: topicTitleTextFieldBottomLineView.bottomAnchor, constant: view.frame.height / 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor).isActive = true
        
        descriptionTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14).isActive = true
        
        descriptionTextFieldBottomLineView.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor).isActive = true
        descriptionTextFieldBottomLineView.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor).isActive = true
        descriptionTextFieldBottomLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64).isActive = true
    }
    
    func setupColorPicker() {
        
        colorPickerView.addHandle(at: selectedColorHandle)
        colorPickerView.addTarget(self, action: #selector(colorPicked(_:)), for: .valueChanged)
        
        view.addSubview(colorPickerView)
        
        colorPickerView.topAnchor.constraint(equalTo: descriptionTextFieldBottomLineView.bottomAnchor, constant: 34).isActive = true
        colorPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorPickerView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        colorPickerView.widthAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
    }
    
    @objc func colorPicked(_ colorPicker: ChromaColorPicker) {
        selectedColorHandle = colorPicker.currentHandle!.color
    }
}

//extension TaskEditViewController: UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.view.endEditing(true)
//    }
//}

