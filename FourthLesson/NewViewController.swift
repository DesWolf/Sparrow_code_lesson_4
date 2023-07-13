//
//  NewViewController.swift
//  FourthLesson
//
//  Created by Максим Окунеев on 13.07.2023.
//

import UIKit

class NewViewController: UIViewController {
    
    private var data: [String] = []
    private var selected: [String] = []
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.allowsMultipleSelection = true
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, String> = {
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = itemIdentifier
            cell?.accessoryType = self.selected.contains(itemIdentifier) ? .checkmark : .none
            return cell
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        for i in 0...30 {
            data.append(String(i))
        }
        
        updateData(data: data, animated: false)
    }
    
    func setupUI() {
        self.view.backgroundColor = .init(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        self.navigationItem.title = "Lesson4"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(shuffleAction))
        
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    @objc func shuffleAction() {
        self.updateData(data: data.shuffled(), animated: true)
    }
    
    
    private func updateData(data: [String], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["first"])
        snapshot.appendItems(data, toSection: "first")
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    
}

extension NewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = dataSource.itemIdentifier(for: indexPath) {
            
            if self.selected.contains(item) {
                selected = selected.filter( { $0 != item })
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                selected.append(item)
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
            if let first = dataSource.snapshot().itemIdentifiers.first, first != item {
                var snapshot = dataSource.snapshot()
                snapshot.moveItem(item, beforeItem: first)
                dataSource.apply(snapshot)
            }
        }
        
        
    }
}
