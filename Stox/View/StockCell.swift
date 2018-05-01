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
                companySymbolLabel.text = symbol
                currentPriceLabel.text = String(format: "$%.02f", price)
            }
            
            if let imageData = stock?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: UIKit Components
    let nameImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tealColor
        return view
    }()
    
    let companySymbolLabel: UILabel = {
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
    
    let priceViewContainer: UIView = {
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
    
    // MARK: Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupObservers()
        backgroundColor = UIColor.tealColor
        
        setupCellUI()
    }
    
    // MARK: NSObserver setup
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePortrait(notification:)), name: NSNotification.Name("portrait"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLandscape(notification:)), name: NSNotification.Name("landscape"), object: nil)
    }
    
    @objc func handlePortrait(notification: NSNotification) {
        print("handling portrait")
        currentPriceLabel.textAlignment = .right
        companySymbolLabel.textAlignment = .left
    }
    
    @objc func handleLandscape(notification: NSNotification) {
        print("handling landscape")
        currentPriceLabel.textAlignment = .center
        companySymbolLabel.textAlignment = .center
    }

    
    // MARK: UI Code
    func setupCellUI() {
        
        let stackView = UIStackView(arrangedSubviews: [nameImageContainerView, priceViewContainer])
        addSubview(stackView)
        nameImageContainerView.addSubview(companySymbolLabel)
        nameImageContainerView.addSubview(companyImageView)
        
        priceViewContainer.addSubview(currentPriceLabel)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.snp.makeConstraints { (make) in
            make.height.leading.trailing.top.bottom.equalToSuperview()
        }
        
        nameImageContainerView.snp.makeConstraints { (make) in
            make.bottom.top.leading.equalToSuperview()
            make.width.equalTo(priceViewContainer.snp.width)
            make.height.equalToSuperview()
        }
        
        companySymbolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(companyImageView.snp.right).offset(18)
            make.top.right.bottom.equalToSuperview()
        }
        
        companyImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        priceViewContainer.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(nameImageContainerView.snp.width)
        }
        
        currentPriceLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }

    // MARK: Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
