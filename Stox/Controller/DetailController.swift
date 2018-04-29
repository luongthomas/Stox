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

    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty").withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
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
        
        lightBlueBackgroundView.addSubview(companyImageView)
        companyImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        lightBlueBackgroundView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(companyImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }

}
