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
    var stockQuotes = [StockQuote]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appleStockQuote = StockQuote(symbol: "APPL", companyName: "Apple Inc.", open: 100, close: 130, high: 150, low: 100, latestPrice: 135.5, changePercent: 0.12)
        
        let googleStockQuote = StockQuote(symbol: "GOOG", companyName: "Google Inc.", open: 240, close: 325, high: 375, low: 159, latestPrice: 330, changePercent: 0.25)
        
        stockQuotes.append(appleStockQuote)
        stockQuotes.append(googleStockQuote)
        
        navigationItem.title = "Stock Quotes"
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Tableview UI settings
        view.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        
    }
    
    // MARK: - Table view footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No information for Stock Quotes available... Swipe down to try again."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return stockQuotes.count == 0 ? 250 : 0
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailController()
        let navController = UINavigationController(rootViewController: detailController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let stockQuote = stockQuotes[indexPath.row]
        
        cell.textLabel?.text = stockQuote.companyName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.tealColor

        return cell
    }

}
