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
                    changePercentLabel.text = "+\(changePercent.rounded(toPlaces: 3))%"
                    changePercentLabel.textColor = UIColor.lightGreen
                } else {
                    changePercentLabel.text = "\(changePercent.rounded(toPlaces: 3))%"
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
    
    var closeValueLabel: UILabel = UILabel()
    var openValueLabel: UILabel = UILabel()
    var openTitleLabel: UILabel = UILabel()
    var closeTitleLabel: UILabel = UILabel()
    
    var openValueContainer: UIView = UIView()
    var closeValueContainer: UIView = UIView()
    var closeTitleContainer: UIView = UIView()
    var openTitleContainer: UIView = UIView()
    
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
        
        closeTitleContainer = createTitleContainerView()
        openTitleContainer = createTitleContainerView()
        closeValueContainer = createTitleContainerView()
        openValueContainer = createTitleContainerView()
        
        closeTitleLabel = createLabel(title: "Close")
        openTitleLabel = createLabel(title: "Open")
        closeValueLabel = createLabel(title: "100")
        openValueLabel = createLabel(title: "10")
        
        if let close = stockQuote?.close, let open = stockQuote?.open {
            openValueLabel.text = String(format: "$%.02f", open)
            closeValueLabel.text = String(format: "$%.02f", close)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        setupStockInfoUI()
        
        if let stockQuote = stockQuote {
            navigationItem.title = stockQuote.symbol
        } else {
            navigationItem.title = "Detail"
        }
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
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
        
        // Open Container Constraint
        let openStackView = UIStackView(arrangedSubviews: [openTitleContainer, openValueContainer])
        openStackView.axis = .vertical
        openStackView.distribution = .fillEqually
        openStackView.spacing = 10
        
        openTitleContainer.addSubview(openTitleLabel)
        openTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        openValueContainer.addSubview(openValueLabel)
        openValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        
        // Close Container Constraints
        closeTitleContainer.addSubview(closeTitleLabel)
        closeTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        closeValueContainer.addSubview(closeValueLabel)
        closeValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        let highStackView = UIStackView(arrangedSubviews: [closeTitleContainer, closeValueContainer])
        highStackView.axis = .vertical
        highStackView.spacing = 10
        highStackView.distribution = .fillEqually
        
        openTitleContainer.addSubview(openTitleLabel)
        openTitleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        openValueContainer.addSubview(openValueLabel)
        openValueLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        changePercentLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
        }
        
        let openCloseStackView = UIStackView(arrangedSubviews: [openStackView, highStackView])
        openCloseStackView.axis = .horizontal
        openCloseStackView.distribution = .fillEqually
        openCloseStackView.spacing = 10
        
        lightBlueBackgroundView.addSubview(openCloseStackView)
        openCloseStackView.snp.makeConstraints { (make) in
            make.top.equalTo(imageNamePriceStackView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }
        
    }
}
