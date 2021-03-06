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
        fetchStocks()
        tableView.reloadData()
    }
    
    func setupUI() {
        navigationItem.title = "Stock Quotes"
        view.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(handleRefresh))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if DeviceType().isPad() {
            print("iPad")
        }
        if DeviceInfo.Orientation.isLandscape {
            print("moving to landscape")
            NotificationCenter.default.post(name: Notification.Name("landscape"), object: nil)
        } else {
            print("moving to portrait")
            NotificationCenter.default.post(name: Notification.Name("portrait"), object: nil)
        }
    }
    
    // MARK: Network calls to get StockQuotes
    @objc func handleRefresh() {
        stockQuotes.removeSampleStockQuotes()
        fetchStocks()
        tableView.reloadData()
    }
    
    func fetchStocks() {
        let chosenStocks = ChosenStocks()
        let client = NetworkClient()
        let urlFactory = URLCreate()
        chosenStocks.symbols.forEach { (stockSymbol) in
            let quoteUrl = urlFactory.createUrlFrom(stockSymbol: stockSymbol)
            let imageUrl = urlFactory.createImageUrlFrom(stockSymbol: stockSymbol)
            client.fromNetworkCreateStockWith(url: quoteUrl, completion: { [unowned self] (stockQuote) in
                var stock = stockQuote
                // Get Image
                client.fromNetworkGetImageOfUrl(url: imageUrl, completion: { [unowned self] (image) in
                    stock.imageData = image
                    // Modify array
                    self.stockQuotes.insert(stockQuote: stock)
                    
                    // Insert new index into tableView
                    let newIndexPath = IndexPath(row: self.stockQuotes.count - 1, section: 0)
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                })
            })
        }
    }
    
    // MARK: - Table view footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No information for Stock Quotes available...\n\n Press the refresh button to try again."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return stockQuotes.count == 0 ? 250 : 0
    }
    
    // MARK: - Table View Cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
