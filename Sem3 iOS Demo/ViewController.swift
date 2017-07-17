//
//  ViewController.swift
//  Sem3 iOS Demo
//
//  Created by Siddharthan Asokan on 16/7/17.
//  Copyright © 2017 Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductdata(upcCode: "640520098967")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchProductdata(upcCode : String){
        let consumer = OAConsumer.init(key: OAUTH_KEY, secret:OAUTH_SECRET)
        let url = URL(string: "https://api.semantics3.com/v1/products")
        let request = OAMutableURLRequest(url: url, consumer: consumer, token: nil, realm: nil, signatureProvider: nil)
        request?.httpMethod = "GET"
        let param = OARequestParameter(name: "q", value: "{\"upc\":\(upcCode)}")
        request?.parameters = [param!]
        let fetcher = OADataFetcher()
        fetcher.fetchData(with: request, delegate: self, didFinish: #selector(requestDidFinishWithData), didFail: #selector(requestDidFailWithError))
    }
    
    
    func requestDidFinishWithData(ticket: OAServiceTicket) {
        do {
            let json = try JSONSerialization.jsonObject(with: ticket.data, options: .mutableContainers)
            print(json)
        } catch let error {
            print(error)
        }
    }
    
    func requestDidFailWithError(error: NSError) {
        print(error.localizedDescription)
    }


}

