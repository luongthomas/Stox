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
            if let symbol = stock?.symbol, let price = stock?.close {
                stockNameLabel.text = symbol
                currentPriceLabel.text = "$\(price.rounded(toPlaces: 2))"
            }
            
            if let imageData = stock?.imageData {
                companyImageView.image = UIImage(data: imageData)
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
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    let priceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkBlue
        view.layer.cornerRadius = 3
        return view
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
        addSubview(priceView)
        priceView.addSubview(currentPriceLabel)
        
        companyImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        stockNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(companyImageView.snp.right).offset(16)
            make.top.right.bottom.equalToSuperview()
        }
        
        priceView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(6)
            make.right.equalToSuperview()
            
        }
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            priceView.snp.makeConstraints { (make) in
                make.width.equalTo(75)
            }
        } else {
            priceView.snp.makeConstraints { (make) in
                make.width.equalTo(25)
            }
        }
        
        currentPriceLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
    }
    
    override func willTransition(to state: UITableViewCellStateMask) {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            
            print("is iPad")
            if DeviceInfo.Orientation.isPortrait {
                
                priceView.snp.remakeConstraints { (make) in
                    make.left.equalTo(75)
                }
            } else {
                priceView.snp.remakeConstraints { (make) in
                    make.left.equalTo(170)
                }
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
