//
//  DetailController.swift
//  Stox
//
//  Created by Puroof on 4/28/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import UIKit
import SnapKit

class DetailController: UIViewController, UINavigationControllerDelegate {

    var stockQuote: StockQuote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        if let stockQuote = stockQuote {
            navigationItem.title = stockQuote.companyName
        } else {
            navigationItem.title = "Detail"
        }
        
    }

    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.darkBlue
        
        let lightBlueBackgroundView = UIView()
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.bottom.right.equalToSuperview().offset(-20)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
