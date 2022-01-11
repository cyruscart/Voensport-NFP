//
//  SportListViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SportListViewController: UIViewController {
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Военный спорт"
        navigationController?.navigationBar.prefersLargeTitles = true
        setTableView()
    }
    
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
    }
    
}

    //MARK: - UITableViewDataSource, UITableViewDelegate

extension SportListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SportType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = SportType.allCases[indexPath.row].rawValue
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTriathlonViewController(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Navigation
    
    private func showTriathlonViewController(index: Int) {
        let triathlonVC = TriathlonViewController()
        triathlonVC.triathlonController = TriathlonController()
        triathlonVC.triathlonController.triathlonType = index == 0 ? .summer : .winter
        navigationController?.pushViewController(triathlonVC, animated: true)
    }
}
