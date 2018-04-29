//
//  StockController.swift
//  Stox
//
//  Created by Puroof on 4/28/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import UIKit

class StockController: UITableViewController {
    
    let cellId = "cellId"
    var stockQuotes = StockQuotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(StockCell.self, forCellReuseIdentifier: cellId)
        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = "Stock Quotes"
        view.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddCompanies", style: .plain, target: self, action: #selector(addStocks))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "RemoveCompanies", style: .plain, target: self, action: #selector(removeStocks))
    }
    
    @objc func addStocks() {
        stockQuotes.addSampleStockQuotes()
        tableView.reloadData()
    }
    
    @objc func removeStocks() {
        stockQuotes.removeSampleStockQuotes()
        tableView.reloadData()
    }
    
    // MARK: - Table view footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No information for Stock Quotes available...\n Swipe down to try again."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return stockQuotes.count == 0 ? 250 : 0
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.stockQuote = stockQuotes.itemAt(row: indexPath.row)
        let navController = UINavigationController(rootViewController: detailController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StockCell
        
        let stockQuote = stockQuotes.itemAt(row: indexPath.row)
        cell.stock = stockQuote
        return cell
    }
    
    
}
