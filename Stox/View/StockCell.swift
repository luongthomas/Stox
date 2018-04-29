//
//  StockCell.swift
//  Stox
//
//  Created by Puroof on 4/28/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
    
    public var stock: StockQuote? {
        didSet {
            if let name = stock?.companyName {
                stockNameLabel.text = name
            }
        }
    }
    
    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "STOCK NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.tealColor
        addSubview(stockNameLabel)
        addSubview(companyImageView)
        
        companyImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        stockNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(companyImageView.snp.right).offset(16)
            make.top.right.bottom.equalToSuperview()
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
