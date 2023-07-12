//
//  ViewController.swift
//  FourthLesson
//
//  Created by Максим Окунеев on 10.07.2023.
//

import UIKit

//На весь экран таблица, в таблице минимум 30 ячеек.
//
//- По нажатию на ячейку она анимировано перемещается на первое место, а справа появляется галочка.
//- Если нажать на ячейку с галочкой, то галочка пропадает.
//- Справа вверху кнопка анимировано перемешивает ячейки.


struct LessonItem {
    let title: Int
    var isSelected: Bool
}

class ViewController: UIViewController {
    
    var mass: [LessonItem] = {
        var mass: [LessonItem] = []
        for elem in 0...30 {
            mass.append(LessonItem(title: elem, isSelected: false))
        }
        
        return mass
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.allowsMultipleSelection = true
    
        table.delegate = self
        table.dataSource = self
        table.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        mass.shuffle()
        tableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LessonCell()
        cell.selectionStyle = .none
        
        cell.textLabel?.text = "\(mass[indexPath.row].title)"

        if mass[indexPath.row].isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        
        let elem = mass[indexPath.row]
        mass.remove(at: indexPath.row)
        mass.insert(LessonItem(title:elem.title, isSelected: true), at: 0)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let elem = mass[indexPath.row]
        mass[indexPath.row] = LessonItem(title: elem.title, isSelected: false)
    }
}
