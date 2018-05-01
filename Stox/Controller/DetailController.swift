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
    
    var stockQuote: StockQuote? {
        didSet {
            if let changePercent = stockQuote?.changePercent {
                
                if changePercent >= 0 {
                    changePercentLabel.text = "+\(changePercent.rounded(toPlaces: 2))%"
                    changePercentLabel.textColor = UIColor.lightGreen
                } else {
                    changePercentLabel.text = "\(changePercent.rounded(toPlaces: 2))%"
                    changePercentLabel.textColor = UIColor.salmonPink
                }
            }
            
            if let currentPrice = stockQuote?.latestPrice, let name = stockQuote?.companyName{
                nameLabel.text = name
                currentPriceLabel.text = String(format: "$%.02f", currentPrice)
                
            }
            
            
            if let imageData = stockQuote?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty").withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var highValueLabel: UILabel = UILabel()
    var lowValueLabel: UILabel = UILabel()
    var lowTitleLabel: UILabel = UILabel()
    var highTitleLabel: UILabel = UILabel()
    
    var lowValueContainer: UIView = UIView()
    var highValueContainer: UIView = UIView()
    var highTitleContainer: UIView = UIView()
    var lowTitleContainer: UIView = UIView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Price"
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let changePercentLabel: UILabel = {
        let label = UILabel()
        label.text = "+1.00%"
        label.textColor = UIColor.lightGreen
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
        
        highTitleContainer = createTitleContainerView()
        lowTitleContainer = createTitleContainerView()
        highValueContainer = createTitleContainerView()
        lowValueContainer = createTitleContainerView()
        
        highTitleLabel = createLabel(title: "High")
        lowTitleLabel = createLabel(title: "Low")
        highValueLabel = createLabel(title: "100")
        lowValueLabel = createLabel(title: "10")
        
        if let high = stockQuote?.high, let low = stockQuote?.low {
            lowValueLabel.text = String(format: "$%.02f", low)
            highValueLabel.text = String(format: "$%.02f", high)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        setupStockInfoUI()
        
        if let stockQuote = stockQuote {
            navigationItem.title = stockQuote.companyName
        } else {
            navigationItem.title = "Detail"
        }
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: NSObserver setup
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePortrait(notification:)), name: NSNotification.Name("portrait"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLandscape(notification:)), name: NSNotification.Name("landscape"), object: nil)
    }
    
    @objc func handlePortrait(notification: NSNotification) {
        
        
    }
    
    @objc func handleLandscape(notification: NSNotification) {
        
    }
    
    // MARK: Creating Container Views and Title Labels
    func createTitleContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightBlue
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }
    
    func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }
    
    // MARK: Set up UI constraints
    private func setupStockInfoUI() {
        view.backgroundColor = UIColor.darkBlue
        
        let lightBlueBackgroundView = UIView()
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.bottom.right.equalToSuperview().offset(-20)
        }
        
        let imageNamePriceStackView = UIStackView(arrangedSubviews: [companyImageView, nameLabel, currentPriceLabel, changePercentLabel])
        imageNamePriceStackView.alignment = .center
        imageNamePriceStackView.axis = .vertical
        imageNamePriceStackView.distribution = .fillProportionally
        
        lightBlueBackgroundView.addSubview(imageNamePriceStackView)
        imageNamePriceStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        companyImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
        }
        
        // Low Values
        let lowStackView = UIStackView(arrangedSubviews: [lowTitleContainer, lowValueContainer])
        lowStackView.axis = .vertical
        lowStackView.distribution = .fillEqually
        
        lowTitleContainer.addSubview(lowTitleLabel)
        lowTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        lowValueContainer.addSubview(lowValueLabel)
        lowValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        
        // High
        highTitleContainer.addSubview(highTitleLabel)
        highTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        highValueContainer.addSubview(highValueLabel)
        highValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        let highStackView = UIStackView(arrangedSubviews: [highTitleContainer, highValueContainer])
        highStackView.axis = .vertical
        highStackView.distribution = .fillEqually
        
        lowTitleContainer.addSubview(lowTitleLabel)
        lowTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        lowValueContainer.addSubview(lowValueLabel)
        lowValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        changePercentLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
        }
        
        let highLowStackView = UIStackView(arrangedSubviews: [highStackView, lowStackView])
        highLowStackView.axis = .horizontal
        highLowStackView.distribution = .fillEqually
        
        lightBlueBackgroundView.addSubview(highLowStackView)
        highLowStackView.snp.makeConstraints { (make) in
            make.top.equalTo(imageNamePriceStackView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
        
    }
}
