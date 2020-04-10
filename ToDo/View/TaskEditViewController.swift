//
//  TaskEditViewController.swift
//  ToDo List
//
//  Created by Alexander on 06.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import ChromaColorPicker
import UIKit

class TaskEditViewController: UIViewController {
    
    var task: Task!
    
    var presenter = TasksGroupsPresenter(taskListService: TaskListService())
    
    let editNewTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 32)
        label.text = "Edit Task"
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
    
    lazy var topicTitleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        tf.delegate = self
        tf.attributedPlaceholder = NSAttributedString(
            string: "Write Topic",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 14)!])
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
    
    lazy var descriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        tf.delegate = self
        tf.attributedPlaceholder = NSAttributedString(
            string: "Write Description",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "Apple SD Gothic Neo", size: 14)!])
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
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.rgb(red: 72, green: 94, blue: 104)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
        setutKeyboardNotification()
        
        setupViews()
        
        setupViewsValues()
    }
    
    private func setupViewController() {
        
        view.backgroundColor = UIColor.rgb(red: 72, green: 94, blue: 104)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
    }
    
    func setutKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 6, right: 0)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 6, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func setupScrollView() {
        
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupColorPicker() {
        
        colorPickerView.addHandle(at: selectedColorHandle)
        colorPickerView.addTarget(self, action: #selector(colorPicked(_:)), for: .valueChanged)
        
        scrollView.addSubview(colorPickerView)
        colorPickerView.topAnchor.constraint(equalTo: descriptionTextFieldBottomLineView.bottomAnchor, constant: 24).isActive = true
        colorPickerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        colorPickerView.heightAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        colorPickerView.widthAnchor.constraint(equalToConstant: view.frame.height / 5).isActive = true
        colorPickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24).isActive = true
    }
    
    @objc func colorPicked(_ colorPicker: ChromaColorPicker) {
        selectedColorHandle = colorPicker.currentHandle!.color
    }
    
    func setupViews() {
        
        setupScrollView()
        
        scrollView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubview(editNewTaskLabel)
        containerView.addSubview(editNewTaskSeparatorView)
        containerView.addSubview(topicTitleLabel)
        containerView.addSubview(topicTitleTextField)
        containerView.addSubview(topicTitleTextFieldBottomLineView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(descriptionTextField)
        containerView.addSubview(descriptionTextFieldBottomLineView)
        
        editNewTaskLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24).isActive = true
        editNewTaskLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24).isActive = true
        
        editNewTaskSeparatorView.leadingAnchor.constraint(equalTo: editNewTaskLabel.trailingAnchor, constant: 42).isActive = true
        editNewTaskSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24).isActive = true
        editNewTaskSeparatorView.centerYAnchor.constraint(equalTo: editNewTaskLabel.centerYAnchor, constant: -4).isActive = true
        
        topicTitleLabel.leadingAnchor.constraint(equalTo: editNewTaskLabel.leadingAnchor).isActive = true
        topicTitleLabel.topAnchor.constraint(equalTo: editNewTaskLabel.bottomAnchor, constant: view.frame.height / 8).isActive = true
        
        topicTitleTextField.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor).isActive = true
        topicTitleTextField.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 14).isActive = true
        
        topicTitleTextFieldBottomLineView.leadingAnchor.constraint(equalTo: topicTitleTextField.leadingAnchor).isActive = true
        topicTitleTextFieldBottomLineView.topAnchor.constraint(equalTo: topicTitleTextField.bottomAnchor).isActive = true
        topicTitleTextFieldBottomLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -64).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: topicTitleTextFieldBottomLineView.bottomAnchor, constant: view.frame.height / 6).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor).isActive = true
        
        descriptionTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14).isActive = true
        
        descriptionTextFieldBottomLineView.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor).isActive = true
        descriptionTextFieldBottomLineView.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor).isActive = true
        descriptionTextFieldBottomLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -64).isActive = true
        
        setupColorPicker()
    }
    
    func setupViewsValues() {
        topicTitleTextField.text = task.title
        descriptionTextField.text = task.descript
    }
    
    @objc func saveTapped() {
        
        let taskColor: [Float]!
        guard let taskNameTrimmedValue = topicTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        var taskDescriptionTrimmedValue = descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if taskDescriptionTrimmedValue!.isEmpty {
            taskDescriptionTrimmedValue = "No Description"
        }
        
        if let currentColor = colorPickerView.currentHandle?.color.cgColor.components {
            taskColor = currentColor.compactMap({ (color) in
                Float(color)
            })
        } else {
            taskColor = [task.red, task.green, task.blue]
        }
        
        presenter.updateTask(taskName: taskNameTrimmedValue, taskDescription: taskDescriptionTrimmedValue, taskColor: taskColor, uuId: task.id)
        
        navigationController?.popViewController(animated: true)
    }
}

extension TaskEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension TaskEditViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
