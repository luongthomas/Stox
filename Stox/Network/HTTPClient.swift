//
//  HTTPClient.swift
//  Stox
//
//  Created by Puroof on 4/29/18.
//  Copyright © 2018 Lithogen. All rights reserved.
//

import Foundation

class HTTPClient {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK:- Public Methods
    func get(url: String, callback: @escaping (_ data: Data?, _ error: Error?)->Void ) {
        guard let link = URL(string: url) else {
            let error = NSError(domain: "URL Error", code: 1, userInfo: nil)
            callback(nil, error)
            return
        }
        let request = URLRequest(url: link)
        let task = session.dataTask(with: request) {(data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}
